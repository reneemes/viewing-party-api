require "rails_helper"

RSpec.describe "Parties Endpoint" do
  describe "happy path" do
    it "can create a new viewing party event" do
      # user = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")

      party_params = {
        "name": "Movie Time!",
        "start_time": "2025-02-01 10:00:00",
        "end_time": "2025-02-01 14:30:00",
        "movie_id": 278,
        "movie_title": "The Shawshank Redemption",
        "api_key":  "abcd123",
        "invitees": [1, 3]
      }

      post api_v1_parties_path, params: party_params, as: :json
      json = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
# require 'pry'; binding.pry
      
      expect(response).to be_successful
      expect(response.code).to eq("201")
# require 'pry'; binding.pry
      expect(json[:name]).to eq("Movie Time!")
      expect(json[:movie_id]).to eq(278)
      expect(json[:movie_title]).to eq("The Shawshank Redemption")
      # expect(json[:api_key]).to eq("abcd123")
      # expect(json[:invitees]).to eq([1, 3])
    end
  end
end