class AddCurrecyToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :currency, :string, :default => "USD"
  end
end
