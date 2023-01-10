class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :invoices
  has_many :user_sales_targets
  has_many :company_sales_targets

  has_many :company_employees
  has_many :companies, through: :company_employees
   validates :email, format: { with: /[a-z\_]+@inviztechnologies.net/,
    message: "only allows @inviztechnologies.net" }


  after_create :send_password

  enum role: { 
    salesman: 0,
    moderator: 1,
    admin: 2,
    super_admin: 3,
   }

  def password_required?
    return false if new_record?
    super
   end
   def send_password
    pass = SecureRandom.hex(6)
    update(password: pass)
    UserMailer.send_password(self, pass).deliver_now
   end

   def assign_to_companies companies
      companies.each do |company|
        self.companies << Company.find(company)
      end
   end
end
