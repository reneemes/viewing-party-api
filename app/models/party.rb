class Party < ApplicationRecord
  # belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true
  # validates :api_key, presence: { require: true }
end