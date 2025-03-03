class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates_uniqueness_of :email
  validates_presence_of :name, :email

  has_secure_password
end
