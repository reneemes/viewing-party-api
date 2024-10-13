class Party < ApplicationRecord
  attr_accessor :movie_runtime
  # belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true

  before_create :check_party_time
  before_create :check_runtime
  
  def hours_to_minutes(time)
    time = time.strftime("%H:%M")
    hours = time[0, 2].to_i
    minutes = time[3, 2].to_i

    total_minutes = (hours * 60) + minutes
  end
  # def check_runtime(runtime)
  #   party_start = hours_to_minutes(self.start_time)
  #   party_end = hours_to_minutes(self.end_time)
    
  #   party_duration = party_end - party_start
    
  #   if party_duration < runtime
  #     errors.add :base, message: "Party duration (#{party_duration} minutes) is shorter than movie runtime (#{runtime} minutes)"
  #     throw(:abort)
  #   end
  # end

  private

  def check_party_time
    if start_time > end_time
      errors.add :base, message: "Party end time cannot be before party start time"
      throw(:abort)
    end
  end

  def check_runtime#(runtime)
    # return if movie_runtime.nil?

    party_start = hours_to_minutes(self.start_time)
    party_end = hours_to_minutes(self.end_time)
    
    party_duration = party_end - party_start
    
    if party_duration < movie_runtime
      errors.add :base, message: "Party duration (#{party_duration} minutes) is shorter than movie runtime (#{movie_runtime} minutes)"
      throw(:abort)
    end
  end
  # def hours_to_minutes(time)
  #   time = time.strftime("%H:%M")
  #   hours = time[0, 2].to_i
  #   minutes = time[3, 2].to_i

  #   total_minutes = (hours * 60) + minutes
  # end
end
