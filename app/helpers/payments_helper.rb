module PaymentsHelper
    def pay_btn(invoice)
        content_tag(:button, "Pay",
            class: %w(btn btn-primary pay-btn), 
            data: { toggle: "modal", 
                target: "#exampleModal", 
                'invoice-id': invoice.id, 
                'invoice-amount': humanized_money_with_symbol(invoice.price),
                'client-name': invoice.client.name
            }
        )
    end
end
