class UserSalesTarget < ApplicationRecord
  belongs_to :user
  belongs_to :company
  monetize :target_cents

end
