class Party < ApplicationRecord
  # attr_accessor :api_key
  # belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true


  # before_create :check_for_api_key
#   private

#     def check_for_api_key
#       require 'pry'; binding.pry
#       if api_key.blank?
#         errors.add :base, message: "is invalid or missing"
#       end
#     end
end