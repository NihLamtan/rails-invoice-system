class AddTrashToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :trash, :boolean, :default => 0
  end
end
