class AddDateToCompanySalesTarget < ActiveRecord::Migration[7.0]
  def change
    add_column :company_sales_targets, :date, :timestamp
  end
end
