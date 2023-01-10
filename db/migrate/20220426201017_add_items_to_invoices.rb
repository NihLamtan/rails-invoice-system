class AddItemsToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :items, :json
  end
end
