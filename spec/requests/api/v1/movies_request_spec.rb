require "rails_helper"

RSpec.describe "Movies Endpoint" do
  describe "happy path" do
    it "can retrieve a list of top rated movies" do

      stubbed_response = File.open("spec/fixtures/tmdb_top_movies_response.json")
      
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated").
      with(query: { api_key: Rails.application.credentials.tmdb[:key] }).
      to_return(status: 200, body: stubbed_response, headers: {})

      get "/api/v1/movies"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)[:data]

      json.each do |movie|
        expect(movie[:id]).to_not be_nil
        expect(movie[:type]).to eq("movie")
        expect(movie[:attributes]).to have_key(:title)
        expect(movie[:attributes]).to have_key(:vote_average)
      end

    end
  end
end
