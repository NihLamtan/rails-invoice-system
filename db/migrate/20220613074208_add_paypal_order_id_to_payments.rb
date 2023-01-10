class AddPaypalOrderIdToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :paypal_order_id, :string
  end
end
