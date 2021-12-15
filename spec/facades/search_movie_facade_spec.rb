require 'rails_helper'

RSpec.describe SearchMovieFacade do
  describe 'movies' do
    xit 'can return up to 40 matching films based on a query', :vcr do
      facade = SearchMovieFacade.new("Pee Wee")

      search = facade.movies

      expect(search.length).to eq 12
      expect(search).to be_a Array
      expect(search.first.title).to eq "Big Top Pee-wee"
    end
  end
end