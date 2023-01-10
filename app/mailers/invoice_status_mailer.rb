class InvoiceStatusMailer < ApplicationMailer
    def full_refund(invoice, email)
        @full_refund = invoice
        mail(to: email, subject: 'Full Refund')
    end

    def partial_refund(invoice, email)
        @invoice = invoice
        mail(to: email, subject: 'Partial Refund')

    end
end
