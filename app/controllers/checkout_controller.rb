class CheckoutController < ApplicationController

    layout "checkout"
    def index
        @invoice = Invoice.find_by(payment_link: params[:payment_link])
        @payment_intent = create_stripe_payment_intent(@invoice.price.cents, @invoice.currency, @invoice.client.stripe_customer_id, @invoice.company.stripe_acc_id)
    end

    def create
        token = payment_params[:token]
        payment_attributes = payment_params.except(:token)
        invoice = Invoice.find(payment_attributes[:invoice_id])
        customer = Customer.find(invoice.id)

        # stripe_customer_create = Stripe::Customer.create({
        #     customer 
        # })

        
       
        @stripe_payment = Stripe::Charge.create({
            amount: invoice.price,
            currency: invoice.price_currency,
            source: token,
            customer: invoice.client.stripe_customer_id
          })
          if @stripe_payment.status == "succeeded"
              
              @stripe_charge = @stripe_payment.id
              @payment = Payment.new(payment_attributes)
              @payment.stripe_charge_id = @stripe_charge
              @payment.status = 1
             
              @payment.save

          end
          render json: @stripe_payment 
    end

    def load_payment
        # render :layout => 'invoice'
        if params[:payment_marchant] == 'paypal' || params[:status] == 'COMPLETED'
            invoice =  Invoice.find(params[:invoice])
            pp_order_id = params[:order_id]
            paypal_payment = Payment.create({
                invoice_id: invoice.id,
                company_id: invoice.company.id,
                client_id: invoice.client.id,
                paypal_order_id: pp_order_id,
                payment_marchant: 1,
                status: 1,
                pp_order_id: params[:order_id]

            })

            # paypal_order_id = 

            invoice_update = invoice.update(status: 1)
            redirect_to thankyou_path
            return

        end

       
        begin
            payment_intent = params[:payment_intent]
            invoice = Invoice.find(params[:invoice])
            

            @stripe_payment_intent = Stripe::PaymentIntent.retrieve(
                id: payment_intent
            )
            
            payment = Payment.create({
                invoice_id: invoice.id,
                company_id: invoice.company.id,
                client_id: invoice.client.id,
                status: 1,
                payment_marchant: 2,
                stripe_charge_id: @stripe_payment_intent.charges.data[0].id,
                stripe_payment_intent: payment_intent,

            })

          

            if payment
                InvoiceMailer.send_invoice_in_mail(invoice, invoice.client.email).deliver_later
                InvoiceMailer.send_invoice_in_mail(invoice, invoice.user.email).deliver_later
                InvoiceMailer.send_invoice_in_mail(invoice, "test@example.com").deliver_later
                client_stipe_payment_intent = invoice.client.update(stripe_payment_intent: @stripe_payment_intent.payment_method)
                invoice_update = invoice.update(status: 1)
            end
        
           redirect_to thankyou_path

        rescue Stripe::InvalidRequestError, ActiveRecord::RecordNotFound
            redirect_to root_path
        end
          
    end

    def thankyou
        render :layout => 'invoice'    
    end
    
    def invoice
        @invoice = Invoice.find_by(payment_link: params[:payment_link])
        render :layout => 'invoice'    
        
    end

    private
    def create_stripe_payment_intent(amount, currency, customer, stripe_acc_id)
        Stripe::PaymentIntent.create(
            amount: amount,
            currency: currency,
            payment_method_types: ['card'],
            customer: customer,
            setup_future_usage: 'off_session',
            transfer_data: {
                destination: stripe_acc_id,
              },
          )
    end

  
  

    def payment_params
        params.require(:payment).permit(:token, :client_id, :company_id, :invoice_id, :status, :stripe_charge_id)
    end
end
