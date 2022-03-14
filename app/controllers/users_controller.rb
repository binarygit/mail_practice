class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_parmas)

    if @user.save
      flash.notice = 'Please check your email for sign up confirmation'
      redirect_to root_path
    else
      render :new
    end
  end
end
