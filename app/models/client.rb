class Client < ApplicationRecord
    has_many :invoices, dependent: :destroy
    has_many :payments
    belongs_to :company

    validates :name, presence: true
    validates :email, presence: true
    validates :phone, presence: true


    include SpreadsheetArchitect

    def spreadsheet_columns
        [
          ['Name', :name],
          ['Email', :email],
          ['Phone', :phone],
          ['currency', :currency],
        ]
      end
end
