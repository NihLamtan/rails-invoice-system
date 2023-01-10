class TargetMailer < ApplicationMailer
    def user_target(user)
        @user_sales_target = user
        mail(to: @user_sales_target.user.email, subject: 'Your target')
    end
end
