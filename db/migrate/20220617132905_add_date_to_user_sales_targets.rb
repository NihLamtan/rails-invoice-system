class AddDateToUserSalesTargets < ActiveRecord::Migration[7.0]
  def change
    add_column :user_sales_targets, :date, :timestamp
  end
end
