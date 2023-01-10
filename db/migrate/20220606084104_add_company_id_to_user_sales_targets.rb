class AddCompanyIdToUserSalesTargets < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_sales_targets, :company, null: false, foreign_key: true
  end
end
