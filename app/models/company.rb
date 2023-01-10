class Company < ApplicationRecord
    has_many :invoices 
    has_many :payments
    has_many :company_sales_targets
    has_many :user_sales_targets
    has_one :companies_connect_paypal
    has_many :clients
    has_many :company_employees
    has_many :employees, through: :company_employees, class_name: "User", foreign_key: "user_id"
    
    has_one_attached :logo do |attachable|
        attachable.variant :thumb, resize_to_limit: [100, 100]
      end
end
