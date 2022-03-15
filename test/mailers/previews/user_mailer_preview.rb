# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def confirmation_mail
    UserMailer.with(user: User.first).confirmation_mail
  end
end
