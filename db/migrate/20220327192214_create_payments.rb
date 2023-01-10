class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :client, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.integer :status
      t.string :stripe_charge_id, null: true

      t.timestamps
    end
  end
end
