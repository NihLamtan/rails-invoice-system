class AddCompanyRefToClients < ActiveRecord::Migration[7.0]
  def change
    add_reference :clients, :company, null: true, foreign_key: true
  end
end
