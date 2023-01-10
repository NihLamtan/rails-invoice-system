class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :client, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.monetize :price
      t.text :description
      t.string :quantity

      t.timestamps
    end
  end
end
