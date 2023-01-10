class CompanySalesTarget < ApplicationRecord
  belongs_to :company
  belongs_to :user

  monetize :target_cents

  validates :target, presence: true

end
