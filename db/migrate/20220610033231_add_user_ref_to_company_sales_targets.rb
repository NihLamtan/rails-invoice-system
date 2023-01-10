class AddUserRefToCompanySalesTargets < ActiveRecord::Migration[7.0]
  def change
    add_reference :company_sales_targets, :user, null: false, foreign_key: true
  end
end
