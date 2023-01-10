class SuperAdmin::DashboardController < SuperAdmin::ApplicationController
    
    
    def index

        if params[:company_id]
            company = Company.find(params[:company_id])
        else
            company = Company.first
        end

        if company
        @total_sales = company.invoices.sum(:price_cents)
        @total_paid_invoice = company.invoices.where(status: "paid").sum(:price_cents)
        @total_paid_refund_invoice = company.invoices.where(status: "refunded").sum(:price_cents)
        @total_un_paid_invoice = company.invoices.where(status: "unpaid").sum(:price_cents)
        @total_invoices = company.invoices.group_by_month(:created_at).sum(:price_cents)
            
        end
    end

      
end
