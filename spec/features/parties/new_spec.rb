require 'rails_helper'

RSpec.describe 'New Party' do
  describe 'happy path' do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)
      @user_4 = create(:user)

      visit '/login'

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password

      click_button

      @facade = MovieDetailsFacade.new(75, @user_1.id)
      @movie = @facade.movie
    end

    it 'provides a form to create a new party', :vcr do
      visit "/movies/#{@movie.id}/viewing-party/new"

      expect(page).to have_content("Create a Viewing Party for #{@movie.title}!")
      expect(page).to have_field(:length, with: @movie.runtime)
      fill_in :start_time, with: DateTime.now
      page.check("#{@user_2.id}")
      page.check("#{@user_3.id}")

      click_button("Create Party")
      expect(current_path).to eq("/dashboard")

      within("#party-#{@movie.id}") do
        expect(page).to have_content("#{@movie.title}")
        expect(page).to have_content("Host")
      end
    end
  end

  describe 'sad path' do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)
      @user_4 = create(:user)

      visit '/login'

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password

      click_button

      @facade = MovieDetailsFacade.new(75, @user_1.id)
      @movie = @facade.movie
    end

    it 'does not create a party without a start time', :vcr do
      visit "/movies/#{@movie.id}/viewing-party/new"

      expect(page).to have_content("Create a Viewing Party for #{@movie.title}!")
      expect(page).to have_field(:length, with: @movie.runtime)
      page.check("#{@user_2.id}")
      page.check("#{@user_3.id}")

      click_button("Create Party")
      expect(current_path).to eq("/movies/#{@movie.id}/viewing-party/new")
      expect(page).to have_content('Could not create viewing party.')
    end

    it 'does not create a party when the length is less than the runtime', :vcr do
      visit "/movies/#{@movie.id}/viewing-party/new"

      fill_in :start_time, with: DateTime.now

      fill_in :length, with: @movie.runtime - 1

      click_button("Create Party")

      expect(current_path).to eq("/movies/#{@movie.id}/viewing-party/new")
      expect(page).to have_content('Could not create party: party length must be greater than movie runtime')
    end
  end
end
