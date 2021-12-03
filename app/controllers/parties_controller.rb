class PartiesController < ApplicationController

  def index
  end

  def new
    @facade = MovieDetailsFacade.new(params[:movie_id], params[:user_id])
  end

  def create
    party = Party.new(party_params)

    if party.save
      UserParty.create(user: User.find(params[:user_id]), party: party)

      user_parties(party)

      redirect_to "/users/#{params[:user_id]}"
    else
      flash[:alert] = 'Could not create viewing party.'
      redirect_to "/users/#{params[:user_id]}/movies/#{params[:movie_id]}/viewing-party/new"
    end
  end

  private

  def party_params
    params.permit(:movie_id, :creator_id, :length, :start_time)
  end

  def user_parties(party)
    params.each do |key, value|
      if value == "1"
        UserParty.create(user: User.find(key), party: party) if key != 'creator_id'
      end
    end
  end
end
