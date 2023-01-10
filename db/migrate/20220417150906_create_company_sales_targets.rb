class CreateCompanySalesTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :company_sales_targets do |t|
      t.references :company, null: false, foreign_key: true
      t.monetize :target

      t.timestamps
    end
  end
end
