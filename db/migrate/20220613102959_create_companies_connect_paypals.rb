class CreateCompaniesConnectPaypals < ActiveRecord::Migration[7.0]
  def change
    create_table :companies_connect_paypals do |t|
      t.string :marchant_id
      t.string :marchant_id_in_pp
      t.string :account_status
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
