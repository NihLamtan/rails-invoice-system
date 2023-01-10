class AddPaymentMarchantToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :payment_marchant, :integer, :null => false, :default => 0
  end
end
