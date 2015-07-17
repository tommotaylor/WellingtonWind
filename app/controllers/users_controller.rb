class UsersController < ApplicationController

  def new
    redirect_to home_path if signed_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to home_path
      flash[:success] = "Thanks for registering!"
    else
      render :new
      flash[:error] = "Sorry there was a problem, please try again"
    end
  end

private
  
  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end

end