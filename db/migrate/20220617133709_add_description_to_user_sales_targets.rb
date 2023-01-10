class AddDescriptionToUserSalesTargets < ActiveRecord::Migration[7.0]
  def change
    add_column :user_sales_targets, :description, :string
  end
end
