require 'rails_helper'

RSpec.describe 'Discover Movies' do
  describe 'when a user visits the discover path' do
    before :each do
      @user_1 = create(:user)

      visit '/login'

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password

      click_button
    end

    it 'has a button to discover top rated movies', :vcr do
      visit "/discover"

      click_button("Top Rated Movies")
    end

    it 'has a search feature for movies', :vcr do
      visit "/discover"

      within("#search") do
        expect(page).to have_content("Search by Keyword")
        fill_in :q, with: 'Pee Wee'
        click_button "Search"
      end
    end

    it 'has a link to the home page' do
      visit "/discover"

      expect(page).to have_link("Home")
    end
  end
end
