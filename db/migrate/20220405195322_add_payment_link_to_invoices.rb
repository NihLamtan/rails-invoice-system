class AddPaymentLinkToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :payment_link, :string
  end
end
