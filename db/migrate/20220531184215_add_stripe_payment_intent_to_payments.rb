class AddStripePaymentIntentToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :stripe_payment_intent, :string
  end
end
