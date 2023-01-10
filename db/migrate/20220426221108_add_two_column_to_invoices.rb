class AddTwoColumnToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :accept_paypal, :boolean, :default => 0
    add_column :invoices, :accept_credit_card, :boolean, :default => 0
  end
end
