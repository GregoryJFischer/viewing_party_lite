require 'rails_helper'


RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it {should validate_presence_of(:password_digest)}
    it {should have_secure_password}
  end

  describe 'relationships' do
    it { should have_many(:user_parties) }
    it { should have_many(:parties).through(:user_parties) }
  end

  describe 'authentication' do
    it 'does not store the password unnencoded' do
      user = create(:user, password: 'test', password_confirmation: 'test')

      expect(user.password_digest).to_not eq 'test'

      expect(user.authenticate('test')).to eq user
      expect(user.authenticate('test1')).to be false
    end
  end
end
