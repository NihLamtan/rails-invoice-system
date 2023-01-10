module InvoicesHelper
    def convert_to_money_object_and_humanized price, currency
        humanized_money_with_symbol(Money.from_amount(price.to_i, currency))
    end
end
