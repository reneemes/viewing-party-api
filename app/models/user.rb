class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: { require: true }
  has_secure_password
  has_secure_token :api_key

  has_many :user_parties, foreign_key: :host_id
  has_many :parties, through: :user_parties
  # has_many :invited_parties, class_name: 'UserParty', foreign_key: :user_id
end