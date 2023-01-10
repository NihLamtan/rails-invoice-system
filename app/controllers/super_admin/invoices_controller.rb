class SuperAdmin::InvoicesController < SuperAdmin::ApplicationController
   before_action :set_invoice, only: %i[ show edit update destroy send_invoice pay ]

    def index

        # @invoices = Invoice.all
        @report = Report.new 


        if params[:status] == 'paid'
            @invoices = Invoice.paginate(page: params[:page], per_page: 8).where(status: 1)
        elsif params[:status] == 'refunded'
            @invoices = Invoice.paginate(page: params[:page], per_page: 8).where(status: 2)
        elsif params[:status] == 'all'
            @invoices = Invoice.paginate(page: params[:page], per_page: 8)
        elsif params[:status] == 'refunded'
            @invoices = Invoice.paginate(page: params[:page], per_page: 8).where(status: 2)
        elsif params[:status] == 'refunded'
            @invoices = Invoice.paginate(page: params[:page], per_page: 8).where(status: 2)
        elsif params[:status] == 'deleted'
            @invoices = company.invoices.paginate(page: params[:page], per_page: 8).where(trash: 1)

        else 
             @invoices = Invoice.paginate(page: params[:page], per_page: 10).order('created_at DESC')
        end    

      


        # @q = Invoice.ransack(params[:q])
        # # @invoices = @q.result(distinct: true)
        # @report_avail = Report.all
    end

    def approved
        paid = 'paid'
        @q = Invoice.where(status: paid).ransack(params[:q])
        @invoices = @q.result(distinct: true)
        @report_avail = Report.all
    end
    def pending
        paid = 'unpaid'
        @q = Invoice.where(status: paid).ransack(params[:q])
        @invoices = @q.result(distinct: true)
        @report_avail = Report.all
    end
    def rejected
        paid = 'refunded'
        @q = Invoice.where(status: paid).ransack(params[:q])
        @invoices = @q.result(distinct: true)
        @report_avail = Report.all
    end
    
    def new
        @invoices = Invoice.new
        @currency = Currency.all
    end

    def create
        # client = find_or_created_client
        # fail
        items = build_items_json
        invoice = current_user.invoices.new(invoice_params.merge(items: items, client_id: invoice_params[:client_id], company_id: invoice_params[:company_id]))
       
        # stripe_customer = Stripe::Customer.create({
        #     description: 'My First Test Customer (created for API docs)',
        #     email: client_invoice.email
        #   })
        #   client_invoice.stripe_customer_id = stripe_customer.id

        if invoice.save
            redirect_to super_admin_invoices_path, notice: "Invoice was successfully created."
        else 
            render :new
        end
    end

    def show
        render :layout => 'invoice'    
    end

    def edit

    end

    def update
       
        items = build_items_json
        
        @invoice.update(invoice_params.merge(items: items, client_id: invoice_params[:client_id], company_id: invoice_params[:company_id]))

        if @invoice
            redirect_to super_admin_invoices_path, notice: 'Invoice updated successfully'
        end
    end

    def send_invoice
        InvoiceMailer.send_invoice_in_mail(@invoice, @invoice.client.email).deliver_later
        InvoiceMailer.send_invoice_in_mail(@invoice, @invoice.user.email).deliver_later
        InvoiceMailer.send_invoice_in_mail(@invoice, "test@example.com").deliver_later

        flash[:notice] = "Invoice Send Successfully"
        redirect_to super_admin_invoices_path 
    end

    def trash_invoice
        @invoice.update(trash: 1)
        fail
        flash[:notice] = "Invoice trash Successfully"
        redirect_to super_admin_invoices_path 
    end
    

    def export
        respond_to do |format|
            format.html do
              @invoices = Invoice.order(created_at: :desc)
            end
            format.xlsx do
                report = Report.last
                @invoices = Invoice.where("created_at >= :start_date AND created_at <= :end_date",
                    {start_date: report[:start_date], end_date: report[:end_date]})
                    render xlsx: 'invoices', template: 'invoices/export'
                Report.destroy_all
            end
          end
    end
    

    def pay

        # fail
        
        charge = Stripe::PaymentIntent.create({
            amount: @invoice.price_cents,
            currency: "usd",
            confirm: true,
            customer: @invoice.client.stripe_customer_id,
            payment_method: "pm_1L6KUkIgCmSXEQIacho8lDiI",
            off_session: true
          })
        
        if charge
            redirect_to super_admin_invoices_path, notice: 'mark as paid invoice'
        end
    end
    private

    def create_stripe_payment_intent(amount)
        Stripe::PaymentIntent.create(
            amount: amount,
            currency: "usd",
            payment_method_types: ['card']
          )
    end

    def set_invoice
        @invoice  = Invoice.find(params[:id])
    end

    def invoice_params
        params.require(:invoice).permit(:company_id, :client_id, :user_id, :price, :description, :currency, :quantity, :tax, :sale_tax, :note, :discount, :accept_paypal, :accept_credit_card, items: {})
    end


   
   
    

    # def find_or_created_client
    #     return Client.find_or_create_by(email: invoice_params[:client_email]) do |c|
    #         c.name = invoice_params[:client_name]
    #         c.phone = invoice_params[:client_phone]
    #     end
    # end

    # def invoice_attributes
    #     invoice_params.except(:client_id, :client_name, :client_phone, :client_email)
    # end

    def build_items_json
        invoice_params[:items]
    end

    

end

