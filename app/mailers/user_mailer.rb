class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_password.subject
  #
  def send_password(user, password)
    @greeting = "Hi"
    @user = user.name
    @email = user.email
    @password = password
    mail to: user.email
  end
end
