class MoviesController < ApplicationController
  def show
    if session[:user_id]
      @facade = MovieDetailsFacade.new(params[:id], params[:user_id])
    else
      flash[:alert] = registration_error
      redirect_to root_path
    end
  end

  def index
    if session[:user_id]
      if params[:q] == "top%40rated"
        @facade = TopMovieFacade.new(params[:id])
      else
        @facade = SearchMovieFacade.new(params[:q], params[:id])
      end
    else
      flash[:alert] = registration_error
      redirect_to root_path
    end
  end
end
