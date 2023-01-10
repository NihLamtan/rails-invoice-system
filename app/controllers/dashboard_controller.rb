class DashboardController < ApplicationController
   before_action :authenticate_user!


    def index
#     company = Company.find(1)
#     @total_paid_invoice_company = company.invoices.where(status: "paid").sum(:price_cents)
    company = load_company
    if company
    @total_paid_invoice_company = company.invoices.where(status: "paid").sum(:price_cents)
    @total_refund_invoice_company = company.invoices.where(status: "refunded").sum(:price_cents)
    @total_unpaid_invoice_company = company.invoices.where(status: "unpaid").sum(:price_cents)
    @total_amount_invoice = company.invoices.sum(:price_cents)
    @total_invoices = company.invoices.group_by_month(:created_at).sum(:price_cents)
    end

    # @total_invoices = Invoice.group_by_month(:created_at).sum(:price_cents)
    # @total_refunded_amount = Payment.where(status: "refunded").sum(:refunded_amount_cents)
    # @unpaid = Invoice.where(status: "unpaid").sum(:price_cents)
    # @refunded_invoices = Payment.group_by_month(:created_at).where(status: "refunded").sum(:refunded_amount_cents)

# @current_user_total_invoice = current_usr.invoices.group_by_month(:created_at).sum(:total_cents)
    # @current_user_paid_invoice_total = current_user.invoices.where(status: "paid").sum(:total_cents)
    # @current_user_refund_invoice_total = current_user.invoices.where(status: "refund").sum(:total_cents)
    # @current_user_unpaid_invoice_total = current_user.invoices.where(status: "unpaid").sum(:total_cents)



    end

    def cookies_update_id
     
         cookies.signed[:company_id] = params[:company_id]  
         redirect_to users_path, notice: "change company"
    end

  

end
