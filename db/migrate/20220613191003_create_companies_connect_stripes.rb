class CreateCompaniesConnectStripes < ActiveRecord::Migration[7.0]
  def change
    create_table :companies_connect_stripes do |t|
      t.string :stripe_acc_id
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
