class AddStripeConnectAccToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :stripe_connect_acc, :string
  end
end
