class CompanyEmployee < ApplicationRecord
  belongs_to :employee, class_name: "User", foreign_key: "user_id"
  belongs_to :company
end
