class AddPriceToPayments < ActiveRecord::Migration[7.0]
  def change
    add_monetize :payments, :refunded_amount, amount: { null: false, default: 0 }
  end
end
