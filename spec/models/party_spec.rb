require "rails_helper"

RSpec.describe Party, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }

    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:movie_title) }
  end

  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
  end

  it "checks the party time is valid" do
    dolly = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")

    expect(Party.all.count).to eq(0)

    party = Party.create(
      name: "Movie Party",
      start_time: "2025-02-01 14:30:00",
      end_time: "2025-02-01 10:00:00",
      movie_id: 278,
      movie_title: "The Shawshank Redemption"
      )
    
    expect(Party.all.count).to eq(0)
  end

  it "checks the runtime of the party to ensure movie duration is not longer" do
    dolly = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")

    party = Party.create(
      name: "Movie Party",
      start_time: "2025-02-01 10:00:00",
      end_time: "2025-02-01 14:30:00",
      movie_id: 278,
      movie_title: "The Shawshank Redemption",
      movie_runtime: 200
      )

    expect(party.errors).to be_empty
  end

  it "handles the runtime being longer than party duration" do
    dolly = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")

    party = Party.create(
      name: "Movie Party",
      start_time: "2025-02-01 10:00:00",
      end_time: "2025-02-01 10:30:00",
      movie_id: 278,
      movie_title: "The Shawshank Redemption",
      movie_runtime: 200
      )

    expect(party.errors).to_not be_empty
    expect(party.errors[:base]).to eq(["Party duration (30 minutes) is shorter than movie runtime (200 minutes)"])
  end
end