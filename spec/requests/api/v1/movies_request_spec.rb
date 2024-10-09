require "rails_helper"

RSpec.describe "Movies Endpoint" do
  describe "happy path" do
    it "can retrieve a list of top rated movies" do

      stubbed_response = File.open("spec/fixtures/tmdb_movie_response.json")
      
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated").
        #  with(
        #    headers: {
        #   'Accept'=>'*/*',
        #   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        #   'User-Agent'=>'Faraday v2.10.1'
        #    }).
        with(query: { api_key: Rails.application.credentials.tmdb[:key] }).
        to_return(status: 200, body: stubbed_response, headers: {})




      get "/api/v1/movies"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)[:data]

      json.each do |json|
        expect(json[:id]).to_not be_nil
        expect(json[:type]).to eq("movie")
        expect(json[:attributes]).to have_key(:title)
        expect(json[:attributes]).to have_key(:vote_average)
      end

    end
  end
end