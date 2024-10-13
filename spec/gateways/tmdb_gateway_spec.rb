require "rails_helper"

RSpec.describe TmdbGateway do
  describe 'get_movies' do
    it 'should return a list of the top 20 rated movies' do
      stubbed_response = File.open("spec/fixtures/tmdb_top_movies_response.json")

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key] })
        .to_return(status: 200, body: stubbed_response, headers: {})

      search = {}

      result = TmdbGateway.get_movies(search)
    
      expect(result.first[:title]).to eq("The Shawshank Redemption")
      expect(result.first[:id]).to eq(278)
      expect(result.first[:vote_average]).to eq(8.707)
    end

    it 'should return a list of movies based on search params' do
      stubbed_response = File.open("spec/fixtures/tmdb_lotr_search_response.json")

      stub_request(:get, "https://api.themoviedb.org/3/search/movie")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key], query: "lord of the rings" })
        .to_return(status: 200, body: stubbed_response, headers: {})

      search = {query: "Lord of the Rings"}

      result = TmdbGateway.get_movies(search)

      expect(result.first).to have_key(:title)
      expect(result.first).to have_key(:vote_average)
      expect(result.first).to have_key(:id)
    end

    it 'handles not being able to connect to the external API' do
      failed_response = {
        "success": false,
        "status_code": 500,
        "status_message": "Internal Server Error"
      }

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key] })
        .to_return(status: 500, body: failed_response.to_json)

      stub_request(:get, "https://api.themoviedb.org/3/search/movie")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key], query: "Lord of the Rings" })
        .to_return(status: 500, body: failed_response.to_json)

      search = {}
      expect {
        TmdbGateway.get_movies(search)
        }.to raise_error(RuntimeError, "Unable to fetch movies")
    end
  end

  describe 'get_movie_by_id' do
    it 'returns all movie info for a given ID number' do
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

      search = 411
      result = TmdbGateway.get_movie_by_id(search)

      expect(result[:movie][:id]).to eq(411)
      expect(result[:movie][:title]).to eq("The Chronicles of Narnia: The Lion, the Witch and the Wardrobe")
    end

    it 'handles a movie ID that does not exist' do
      failed_response = {
        "success": false,
        "status_code": 34,
        "status_message": "The resource you requested could not be found."
      }

      stub_request(:get, "https://api.themoviedb.org/3/movie/999999999")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key]})
        .to_return(status: 404, body: failed_response.to_json)

      search = 999999999
      expect {
        TmdbGateway.get_movie_by_id(search)
        }.to raise_error(RuntimeError, "Unable to locate movie with ID 999999999")
    end
  end

  describe 'get_movie' do
    it 'should return one movie by searching for the ID number' do
      stubbed_response = File.open("spec/fixtures/tmdb_movie_response.json")

      stub_request(:get, "https://api.themoviedb.org/3/movie/411")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key] })
        .to_return(status: 200, body: stubbed_response, headers: {})

      search = 411
      result = TmdbGateway.get_movie(search)

      expect(result[:id]).to eq(411)
      expect(result[:title]).to eq("The Chronicles of Narnia: The Lion, the Witch and the Wardrobe")
      expect(result[:runtime]).to eq(143)
    end
  end
end
