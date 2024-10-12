require "rails_helper"

RSpec.describe "Parties Endpoint" do
  describe "happy path" do
    it "can create a new viewing party event" do
      danny = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "jerseyMikesRox7")
      dolly = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")
      messi = User.create!(name: "Lionel Messi", username: "futbol_geek", password: "test123")
      
      party_params = {
        "name": "Movie Time!",
        "start_time": "2025-02-01 10:00:00",
        "end_time": "2025-02-01 14:30:00",
        "movie_id": 278,
        "movie_title": "The Shawshank Redemption",
        "api_key":  dolly.api_key,
        "invitees": [danny.id, messi.id]
      }
      expect(UserParty.all.count).to eq(0)
      post api_v1_parties_path, params: party_params, as: :json
      json = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

      expect(response).to be_successful
      expect(response.code).to eq("201")

      expect(json[:name]).to eq("Movie Time!")
      expect(json[:movie_id]).to eq(278)
      expect(json[:movie_title]).to eq("The Shawshank Redemption")

      expect(UserParty.all.count).to eq(3)
      host = UserParty.find_by(user_id: dolly.id)
      invitee = UserParty.find_by(user_id: messi.id)
      expect(host.is_host).to be(true)
      expect(invitee.is_host).to be(false)
    end
  end

  describe "sad path" do
    it "handles invalid api keys" do
      party_params = {
        "name": "Movie Time!",
        "start_time": "2025-02-01 10:00:00",
        "end_time": "2025-02-01 14:30:00",
        "movie_id": 278,
        "movie_title": "The Shawshank Redemption",
        "api_key":  "abc123",
        "invitees": [1, 3]
      }

      post api_v1_parties_path, params: party_params, as: :json
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(response.code).to eq("404")
      expect(json[:message]).to eq("No user found")
    end

    it "handles a missing api key" do
      party_params = {
        "name": "Movie Time!",
        "start_time": "2025-02-01 10:00:00",
        "end_time": "2025-02-01 14:30:00",
        "movie_id": 278,
        "movie_title": "The Shawshank Redemption",
        "invitees": [1, 3]
      }

      post api_v1_parties_path, params: party_params, as: :json
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(response.code).to eq("401")
      expect(json[:message]).to eq("Invalid or missing API key")
    end

    it "handles a party not successfully created" do
      dolly = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")

      party_params = {
        "start_time": "2025-02-01 10:00:00",
        "end_time": "2025-02-01 14:30:00",
        "movie_id": 278,
        "movie_title": "The Shawshank Redemption",
        "api_key": dolly.api_key,
        "invitees": [1, 3]
      }

      post api_v1_parties_path, params: party_params, as: :json
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.code).to eq("422")
      expect(json[:message]).to eq(:name=>["can't be blank"])
      # expect(json[:message]).to eq('Cannot complete creation')
    end

    it "handles creating a party while excluding invalid invitee user id" do
      dolly = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")
      messi = User.create!(name: "Lionel Messi", username: "futbol_geek", password: "test123")

      party_params = {
        "name": "Dolly's Movie Party!",
        "start_time": "2025-02-01 10:00:00",
        "end_time": "2025-02-01 14:30:00",
        "movie_id": 278,
        "movie_title": "The Shawshank Redemption",
        "api_key": dolly.api_key,
        "invitees": [messi.id, 100]
      }

      expect(UserParty.all.count).to eq(0)

      post api_v1_parties_path, params: party_params, as: :json
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.code).to eq("201")
      expect(UserParty.all.count).to eq(2)
    end

    it "handles party end time being before start time" do
      dolly = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")

      party_params = {
        "name": "Movie Time!",
        "start_time": "2025-02-01 14:30:00",
        "end_time": "2025-02-01 10:00:00",
        "movie_id": 278,
        "movie_title": "The Shawshank Redemption",
        "api_key":  dolly.api_key,
        "invitees": [1, 3]
      }

      post api_v1_parties_path, params: party_params, as: :json
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.code).to eq("422")
      expect(json[:message][:base]).to eq(["Party end time cannot be before party start time"])
    end

  end
end