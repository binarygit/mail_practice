class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)

    if @user.save
      UserMailer.with(user: @user).confirmation_mail.deliver_later
      flash.notice = 'Please check your email for sign up confirmation'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def new_user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :password, :username, :password_confirmation)
  end
end
