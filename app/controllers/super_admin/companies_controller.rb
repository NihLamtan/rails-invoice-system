class SuperAdmin::CompaniesController < SuperAdmin::ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  # GET /companies or /companies.json
  def index
    @companies = Company.paginate(:page => params[:page], per_page: 8)

  end

  # GET /companies/1 or /companies/1.json
  def show
    @invoices = @company.invoices.paginate(:page => params[:page], per_page: 8)
    @targets = @company.company_sales_targets
    @data = stripe_create_account_link

   
    stripe_acc_id = params[:acc_id]

    # stripe_acc_retrieve =  Stripe::Account.retrieve(stripe_acc_id)

    
    if stripe_acc_id 
    # save_stripe_acc_id = CompaniesConnectStripe.create({
    #   stripe_acc_id: stripe_acc_id,
    #   company_id: @company.id
    # })

      @company.update({
        stripe_acc_id:  stripe_acc_id
      })
      @company.save
    end

    # redirect_to super_admin_companies_path, notice: 'account connect  successfuly'


    if params[:merchantId]
    company_connect_paypal = CompaniesConnectPaypal.create({
      company_id: @company.id,
      marchant_id: params[:merchantId],
      marchant_id_in_pp: params[:merchantIdInPayPal],
      account_status: params[:accountStatus],

    })
    redirect_to super_admin_companies_path, notice: "company connect successfully"

    end

  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  def clients
    company = Company.find(params[:id])
    company_clients = company.clients
    render :json => company_clients
  end

  def users
    company = Company.find(params[:company_id])
    users = company.company_employees
    render :json => users
  end
  # POST /companies or /companies.json
  def create
    connet_acc_stripe = params[:code]
    @company = Company.new(company_params)
    @company.stripe_connect_acc = connet_acc_stripe

    respond_to do |format|
      if @company.save
        format.html { redirect_to super_admin_companies_path, notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to super_admin_company_url(@company), notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def paypal
    company = set_company()
    @data = generate_paypal_signup_url["links"][1]['href']
    @data_stripe_account = stripe_create_account_link(company)
  end
  
  def stripe_create_account_link(company)
    stripe_account = Stripe::Account.create({
      type: 'express',
      business_type: "individual",
      company: {
        name: company.name
      }
    })
    # stripe_acc_retrieve = Stripe::Account.retrieve('acct_1KEN8rIgCmSXEQIa')

    stripe_account_onboarding_link = Stripe::AccountLink.create(
       account: stripe_account.id,
       refresh_url: 'http://localhost:3001/',
       return_url: super_admin_company_url + "?acc_id=#{stripe_account.id}",
       type: 'account_onboarding',
     )
   end

   def paypal_refund 
      company = Company.find(params[:company_id])
        paypal_refund_req = Faraday.new('https://api-m.sandbox.paypal.com/') do |con|
          con.request :authorization, 'Bearer', paypal_access_token
          con.request :json
          con.response :json
        end
        paypal_response = paypal_refund_req.post("/v2/payments/captures/#{company.payments.paypal}/refund")
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :logo, :email)
    end

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
          "return_url": super_admin_company_url,
          "return_url_description": "the url to return the merchant after the paypal onboarding process."
        }
      }.to_json
    end


 
end
