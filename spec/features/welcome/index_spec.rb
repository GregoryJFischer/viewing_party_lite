require 'rails_helper'

RSpec.describe 'Landing Page' do
  describe 'when a user visits the landing page' do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user)
      visit root_path
    end

    it 'has a title' do
      within("#header") do
        expect(page).to have_content("Viewing Party Light")
      end
    end

    it 'has a link to create a new user' do
      expect(page).to have_link("register")
    end

    it 'has a list of exisiting users' do
      visit '/login'

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password

      click_button

      visit root_path

      within("#user-#{@user_1.id}") do
        expect(page).to have_content(@user_1.email)
      end
      within("#user-#{@user_2.id}") do
        expect(page).to have_content(@user_2.email)
      end
    end

    it 'has a link back to the home page' do
      expect(page).to have_link("Home")

      click_link("Home")

      expect(current_path).to eq(root_path)
    end

    it 'can log out' do
      visit '/login'

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password

      click_button

      visit root_path

      expect(page).to have_link('log out')
      expect(page).not_to have_link('log in')

      click_link("log out")

      expect(page).to have_link('log in')
      expect(page).not_to have_link('log out')
    end
  end
end
