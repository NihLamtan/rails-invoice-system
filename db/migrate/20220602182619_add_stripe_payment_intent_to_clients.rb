class AddStripePaymentIntentToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :stripe_payment_intent, :string
  end
end
