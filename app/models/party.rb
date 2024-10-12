class Party < ApplicationRecord
  # belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true

  before_create :check_party_time

  private

  def check_party_time
    # require 'pry'; binding.pry
    if start_time > end_time
      errors.add :base, message: "Party end time cannot be before party start time"
      throw(:abort)
    end
  end
end
