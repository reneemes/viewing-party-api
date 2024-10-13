require "rails_helper"

RSpec.describe "Movies Endpoint" do
  describe "happy path" do
    it "can retrieve a list of top rated movies" do
      stubbed_response = File.open("spec/fixtures/tmdb_top_movies_response.json")
      
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key] })
        .to_return(status: 200, body: stubbed_response, headers: {})

      get "/api/v1/movies"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(json.length).to eq(20)
      
      json.each do |movie|
        expect(movie[:id]).to_not be_nil
        expect(movie[:type]).to eq("movie")
        expect(movie[:attributes]).to have_key(:title)
        expect(movie[:attributes]).to have_key(:vote_average)
      end

    end

    it "can search for movies by title" do
      stubbed_response = File.open("spec/fixtures/tmdb_lotr_search_response.json")

      stub_request(:get, "https://api.themoviedb.org/3/search/movie")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key], query: "lord of the rings" })
        .to_return(status: 200, body: stubbed_response, headers: {})


      get "/api/v1/movies", params: { query: "Lord of the Rings" }

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)[:data]

      json.each do |movie|
        expect(movie[:id]).to_not be_nil
        expect(movie[:type]).to eq("movie")
        expect(movie[:attributes]).to have_key(:title)
        expect(movie[:attributes]).to have_key(:vote_average)
      end

    end

    it "can search for one movie and return detailed information" do
      movie_response = File.open("spec/fixtures/tmdb_movie_response.json")
      cast_response = File.open("spec/fixtures/tmdb_cast_response.json")
      reviews_response = File.open("spec/fixtures/tmdb_reviews_response.json")

      stub_request(:get, "https://api.themoviedb.org/3/movie/411")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key]})
        .to_return(status: 200, body: movie_response, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/movie/411/credits")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key]})
        .to_return(status: 200, body: cast_response, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/movie/411/reviews")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key]})
        .to_return(status: 200, body: reviews_response, headers: {})
        
      get "/api/v1/movies/411"

      expect(response).to be_successful  
      json = JSON.parse(response.body, symbolize_names: true)[:data]

    end
  end

  describe "Sad Path" do
    it "handles not being able to process top 20 movies requests" do
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key] })
        .to_return(status: 503, body: {error: "Cannot connect to The Movie Database."}.to_json)

      get "/api/v1/movies"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(503)
      expect(json[:message]).to eq("Unable to fetch movies from the external API.")
    end

    it "handles not being able to process a tmdb search" do
      stub_request(:get, "https://api.themoviedb.org/3/search/movie")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key], query: "lord of the rings" })
        .to_return(status: 404, body: {error: "Cannot connect to The Movie Database."}.to_json)

      get "/api/v1/search/movies?query=lord%20of%20the%20rings"


      expect(response).to_not be_successful
      expect(response).to have_http_status(404)
    end

    it "handles no movie by searched ID number" do

    end
  end
end
