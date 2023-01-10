class AddInvoiceNumToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :invoice_num, :string
   add_index :invoices, :invoice_num, unique: true

  end

end
