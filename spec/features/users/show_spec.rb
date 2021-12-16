require 'rails_helper'

RSpec.describe 'User Dashboard' do
  describe 'when a user visits their dashboard' do
    before :each do
      @user_1 = create(:user, password: '123', password_confirmation: '123')
      @user_2 = create(:user)

      visit '/login'

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button

      visit "/dashboard"
    end

    it 'has their name' do
      expect(page).to have_content("#{@user_1.name}'s Dashboard")
      expect(page).to_not have_content(@user_2.name)
    end

    it 'has a button to discover movies', :vcr do
      click_button "Discover Movies"
      expect(current_path).to eq("/discover")
    end

    it 'has a section for viewing parties and their details' do
      expect(page).to have_content("Viewing Parties")
    end
  end
end
