class Party < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  has_many :user_parties
  has_many :users, through: :user_parties
end