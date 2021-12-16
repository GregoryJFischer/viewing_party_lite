class UsersController < ApplicationController

  def show
    if session[:user_id]
      @facade = UserFacade.new(User.find(session[:user_id]))
    else
      flash[:alert] = registration_error
      redirect_to root_path
    end
  end

  def new
  end

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def discover
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      flash[:alert] = registration_error
      redirect_to root_path
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
