require 'rails_helper'

RSpec.describe TopMovieFacade do
  describe 'movies' do
    xit 'can return 40 top rated films', :vcr do
      facade = TopMovieFacade.new
      top_films = facade.movies

      expect(top_films).to be_an(Array)
      expect(top_films.count).to eq(40)
      expect(top_films.first.title).to eq("Dilwale Dulhania Le Jayenge")
      expect(top_films.last.title).to eq("Black Beauty")
    end
  end
end
