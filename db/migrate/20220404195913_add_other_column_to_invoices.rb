class AddOtherColumnToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_monetize :invoices, :discount
    add_monetize :invoices, :tax
    add_monetize :invoices, :total
  end
end
