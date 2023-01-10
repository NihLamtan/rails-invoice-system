class CreateCompanyEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :company_employees do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.timestamps
    end
  end
end
