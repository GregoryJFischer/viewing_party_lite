require 'rails_helper'

describe 'loggin form' do
  before :each do
    @user = create(:user, email: 'a', password: 'a', password_confirmation: 'a')
  end

  it 'can loggin a user' do
    visit '/login'

    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password

    click_button

    expect(current_path).to eq user_path(@user)
  end

  it "doesn't loggin if password is wrong" do
    visit '/login'

    fill_in 'email', with: @user.email
    fill_in 'password', with: 'b'

    click_button

    expect(current_path).to eq '/login'
    expect(page).to have_content 'Incorrect password'
  end

  it "doesn't loggin if email is wrong" do
    visit '/login'

    fill_in 'email', with: "Not an actual email"
    fill_in 'password', with: @user.password

    click_button

    expect(current_path).to eq '/login'
    expect(page).to have_content 'No user matches your email'
  end
end