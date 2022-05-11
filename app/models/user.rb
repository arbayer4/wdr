class User < ApplicationRecord
  has_secure_password
  
  has_many :game_users
  has_many :games, through: :game_users

  validates_presence_of :email
  validates_uniqueness_of :email
end
