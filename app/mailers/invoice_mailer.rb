class InvoiceMailer < ApplicationMailer
    

    def send_invoice_in_mail(invoice, email)
        @invoice = invoice
         mail(to: email, subject: 'Paid Invoice')
    end


   
end
