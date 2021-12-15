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

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])

    if user
      if user.authenticate(params[:password])
        redirect_to user_path(user)
      else
        flash[:alert] = 'Incorrect password'
        redirect_to '/login'
      end
    else
      flash[:alert] = 'No user matches your email'
      redirect_to '/login'
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
