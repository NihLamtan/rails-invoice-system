class AddPpOrderIdToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :pp_order_id, :string
  end
end
