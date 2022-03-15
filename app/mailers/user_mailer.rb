class UserMailer < ApplicationMailer
  default from: 'example@example.com'

  def confirmation_mail
    @user = params[:user]
    mail to: @user.email, subject: 'You have successfully signed up'
  end
end
