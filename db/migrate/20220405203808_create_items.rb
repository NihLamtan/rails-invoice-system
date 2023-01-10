class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :description
      t.monetize :price
      t.string :quantity
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
