class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
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

  def destroy
    session.destroy
    redirect_to root_path
  end
end