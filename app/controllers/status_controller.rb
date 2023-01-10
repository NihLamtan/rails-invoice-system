class StatusController < ApplicationController
    before_action :authenticate_user!
    

    def refunded_payment
        @refunded_payment = Payment.where(status: "refunded")
    end
    def success_payment
        @success_payment = Payment.where(status: "paid")
    end
end
