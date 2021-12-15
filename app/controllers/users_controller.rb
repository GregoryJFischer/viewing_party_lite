class UsersController < ApplicationController

  def show
    @facade = UserFacade.new(User.find(params[:id]))
  end

  def new
  end

  def create
    user = User.create!(user_params)
    redirect_to user_path(user)
  end

  def discover
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
