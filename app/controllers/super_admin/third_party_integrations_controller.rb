class SuperAdmin::ThirdPartyIntegrationsController < SuperAdmin::ApplicationController

  def index
    @paypal_sign_up_url = generate_paypal_signup_url["links"][1]['href']
    @data = stripe_create_account_link
  end

  private

    # stripe connect integration
    def stripe_create_account_link
     stripe_account = Stripe::Account.create(type: 'express')
     stripe_account_onboarding_link = Stripe::AccountLink.create(
        account: stripe_account.id,
        refresh_url: 'http://localhost:3000/',
        return_url: 'http://localhost:3000/super_admin/companies/1/connect/stripe',
        type: 'account_onboarding',
      )
    end

    # paypal integration
    def grant_new_paypal_access_token
      paypal_req = Faraday.new('https://api-m.sandbox.paypal.com/') do |con|
        con.request :authorization, :basic, ENV["PAYPAL_CLIENT_ID"], ENV["PAYPAL_SECRET_KEY"]
        con.request :url_encoded
        con.headers['Accept'] = 'application/json'
        con.headers['Accept-Language'] = 'en_US'
      end
      paypal_response = paypal_req.post('/v1/oauth2/token', grant_type: 'client_credentials')
      response_body = JSON.parse(paypal_response.body)
      store_access_token_in_cookie response_body['access_token'],
        response_body['expires_in'],
        request.host
      response_body['access_token']
    end

    def store_access_token_in_cookie access_token, expire, host = '/'
      cookies.encrypted[:pp_access_token] = {
        value: access_token,
        expires: Time.at(expire),
        domain: host
      }
    end

    def paypal_access_token
      if cookies.encrypted[:pp_access_token]
        cookies.encrypted[:pp_access_token]
      else
        grant_new_paypal_access_token
      end
    end

    def generate_paypal_signup_url
      paypal_req = Faraday.new('https://api-m.sandbox.paypal.com/') do |con|
        con.request :authorization, 'Bearer', paypal_access_token
        con.request :json
        con.response :json
      end
      paypal_response = paypal_req.post('/v2/customer/partner-referrals', paypal_signup_url_attribute)
      response_body = paypal_response.body
    end

    def paypal_signup_url_attribute
      {
        "operations": [
            {
                "operation": "API_INTEGRATION",
                "api_integration_preference": {
                    "rest_api_integration": {
                        "integration_method": "PAYPAL",
                        "integration_type": "THIRD_PARTY",
                        "third_party_details": {
                            "features": [
                                "PAYMENT",
                                "REFUND"
                            ]
                        }
                    }
                }
            }
        ],
        "products": [
            "EXPRESS_CHECKOUT"
        ],
        "legal_consents": [
            {
                "type": "SHARE_DATA_CONSENT",
                "granted": true
            }
        ],
        "partner_config_override": {
          "return_url": "http://localhost:3000/super_admin/companies/1",
          "return_url_description": "the url to return the merchant after the paypal onboarding process."
        }
      }.to_json
    end

end
