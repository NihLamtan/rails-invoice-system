# raise "STRIPE SECRET KEY NOT SET" unless ENV["STRIPE_SECRET_KEY"]

Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
STRIPE_JS_HOST = "https://js.stripe.com/v3/"