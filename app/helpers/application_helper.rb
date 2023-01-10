module ApplicationHelper
    def stripe_connect_button redirect_uri
        stripe_url = "https://connect.stripe.com/express/oauth/authorize?response_type=code"
        client_id = ENV["STRIPE_CLIENT_ID"]
        
        link_to "Connect to Stripe", "#{stripe_url}&return_url=#{redirect_uri}&client_id=#{client_id}&scope=read_write", class: "stripe-btn"      
      end
end
