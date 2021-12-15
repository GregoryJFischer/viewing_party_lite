require 'rails_helper'

RSpec.describe SearchMovieFacade do
  describe 'movies' do
    it 'can return up to 40 matching films based on a query', :vcr do
      facade = SearchMovieFacade.new("Pee Wee")

      search = facade.movies

      expect(search.length).to eq 12
      expect(search).to be_a Array
      expect(search.first.title).to eq "Pimpin' Pee Wee"
    end
  end
end