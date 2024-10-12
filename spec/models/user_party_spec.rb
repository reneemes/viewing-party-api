require "rails_helper"

RSpec.describe UserParty, type: :model do
  # describe "validations" do
  #   it { should validate_presence_of(:name) }
  #   it { should validate_presence_of(:username) }
  #   it { should validate_uniqueness_of(:username) }
  #   it { should validate_presence_of(:password) }
  #   it { should have_secure_password }
  #   it { should have_secure_token(:api_key) }
  # end

  describe "relationships" do
    it { should belong_to :party }
    it { should belong_to :user }
  end
end