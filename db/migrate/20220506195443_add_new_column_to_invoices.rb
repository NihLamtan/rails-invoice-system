class AddNewColumnToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :sale_tax, :string
    add_column :invoices, :note, :string
  end
end
