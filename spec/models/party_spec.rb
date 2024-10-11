require "rails_helper"

RSpec.describe Party, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }

    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:movie_title) }
    # it { should validate_presence_of(:api_key) }
  end

  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
    # it { should belong_to(:user).with_foreign_key('user_id') }
  end
end