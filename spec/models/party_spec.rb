require "rails_helper"

RSpec.describe Party, type: :model do
  describe "validations" do
    # it { should validate_presence_of(:name) }
    # it { should validate_presence_of(:username) }
    # it { should validate_uniqueness_of(:username) }
    # it { should validate_presence_of(:password) }
    # it { should have_secure_password }
    # it { should have_secure_token(:api_key) }
  end

  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
    it { should belong_to(:user).with_foreign_key('host_id') }
  end
end