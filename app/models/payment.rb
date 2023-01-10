class Payment < ApplicationRecord
  belongs_to :client
  belongs_to :invoice
  belongs_to :company

  
  monetize :refunded_amount_cents

  enum status: { 
    unpaid: 0,
    paid: 1,
    refunded: 2,
    partial_refund: 3
   }

   enum payment_marchant: { 
    paypal: 1,
    stripe: 2,
   }

end
