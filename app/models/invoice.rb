class Invoice < ApplicationRecord
  after_create :generate_payment_link
  after_create :invoice_order_num_gen

  
  after_create :price_save
  after_update :price_save



  belongs_to :client
  belongs_to :company
  belongs_to :user
  has_one :payment

  monetize :price_cents
  monetize :tax_cents
  monetize :total_cents
  monetize :discount_cents

  enum status: { 
    unpaid: 0,
    paid: 1,
    refunded: 2,
    partial_refund: 3
   }
   



  def generate_payment_link
    self.payment_link = generate_link
  end

  def generate_link
    loop do
      link = SecureRandom.hex(10)

      break link unless Invoice.where(payment_link: link).exists?
    end
  end

 
  def invoice_order_num_gen
    invoice_prefix = self.company.name.split(" ").map { |c| c[0] }.join
    invoice_number = sprintf("#{invoice_prefix}%05d", self.id)
    self.invoice_num = invoice_number
    # self.save
  end

  

  def price_save
    # parse_items_json = JSON.parse(self.items)
    total = self.items.values.sum { |item| item['price'].to_i }
    new_price = Money.from_amount(total, self.currency)

    if new_price.cents != self.price_cents
      self.price = new_price
      self.total = new_price
      update_currencies
      total_amount
      self.save
    end

  end

  def update_currencies
    self.discount_currency = self.currency
    self.tax_currency = self.currency
    self.price_currency = self.currency
  end


def total_amount
    discount = self.price - self.discount  
    tax_cal = (self.tax.to_i / 100 ) * discount
    total_deducton = tax_cal + discount # 100 * (13/100)
    self.total = total_deducton
  end



end
