class CreateUserSalesTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sales_targets do |t|
      t.references :user, null: false, foreign_key: true
      t.monetize :target
      t.timestamps
    end
  end
end
