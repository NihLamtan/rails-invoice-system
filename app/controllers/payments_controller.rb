class PaymentsController < ApplicationController
   before_action :authenticate_user!

    def create
        token = payment_params[:token]
        payment_attributes = payment_params.except(:token)
        invoice = Invoice.find(payment_attributes[:invoice_id])

     

        @stripe_payment = Stripe::Charge.create({
            amount: invoice.price.cents,
            currency: "usd",
            customer: invoice.client.stripe_customer_id
          })
          if @stripe_payment.status == "succeeded"
              invoice.update({
                  status: 1
              })
              @stripe_charge = @stripe_payment.id
              @payment = Payment.new(payment_attributes)
              @payment.stripe_charge_id = @stripe_charge
              @payment.status = 1
             
              @payment.save

          end
          render json: @stripe_payment
    end

   

    private
    

    def payment_params
        params.require(:payment).permit(:token, :client_id, :company_id, :invoice_id, :status, :stripe_charge_id)
    end
end
