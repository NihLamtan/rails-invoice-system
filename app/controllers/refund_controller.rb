class RefundController < ApplicationController
    before_action :authenticate_user!
    #load_and_authorize_resource


    def create
        invoice = Invoice.find(params[:invoice_id])
        payment_invoice = invoice.payment

       

        return redirect_to clients_path, notice: "already refunded" if payment_invoice.refunded? || payment_invoice.refunded_amount.cents == invoice.total_cents

        already_refunded = payment_invoice.refunded_amount.cents  # 50 - 10 = 40
        refunded_amount_params = Money.from_amount(refund_params[:refunded_amount].to_i)
        # 40 - 4 = 36
        amount_to_refund = refunded_amount_params.cents if already_refunded < invoice.total_cents
        # refuned amount 4

        full_refund_remaining_amount = invoice.total_cents - already_refunded

        # stripe_acc_retrieve =  Stripe::Account.retrieve(invoice.company.stripe_acc_id)


        
      if params[:refund_option] == "partial_refund" && amount_to_refund > 0
            stripe_refund = Stripe::Refund.create({
                amount: amount_to_refund,
                charge: invoice.payment.stripe_charge_id,    
                reverse_transfer: true,
                refund_application_fee: true,
                # stripe_account: invoice.company.stripe_acc_id
                # payment_intent: invoice.payment.stripe_payment_intent,
            })
            amount_refunded = already_refunded + amount_to_refund
            payment_invoice.update({ refunded_amount: Money.new(amount_refunded), status: 3})  
            invoice.update({
                status: 3
            })   

            
              InvoiceStatusMailer.partial_refund(invoice, invoice.client.email).deliver_later
              InvoiceStatusMailer.partial_refund(invoice, invoice.user.email).deliver_later
              InvoiceStatusMailer.partial_refund(invoice, "test@example.com").deliver_later


        
            
            # payment_invoice.update({ refunded_amount: payment_invoice.refunded_amount.cents + amount_to_refund})
        end

        
        if params[:refund_option] == "full_refund"
            stripe_refund = Stripe::Refund.create({
                amount: full_refund_remaining_amount,
                charge: invoice.payment.stripe_charge_id,
                reverse_transfer: true,
                refund_application_fee: true,
                
            })
            payment_invoice.update({ refunded_amount: Money.new(invoice.price), status: 2})   
            invoice.update({
                status: 2
            })
        InvoiceStatusMailer.full_refund(invoice).deliver_now
        
        end

        # if params[:refund_option] == "full_refund" && amount_to_refund > 0
        #     stripe_refund = Stripe::Refund.create({
        #         amount: Money.new(refund_params).cents,
        #         charge: payment_invoice.stripe_charge_id
        #     })

        #     payment_invoice.refunded! && payment_invoice.update({ refunded_amount: payment_invoice.refunded_amount_cents + stripe_refund.amount}) && invoice.update({ status: 2 }) if stripe_refund.status == "succeeded"

        # end
            
        redirect_to clients_path, notice: "refunded"

    end


        private

        def refund_params
            params.permit(:refunded_amount)
        end

    end

   

    
