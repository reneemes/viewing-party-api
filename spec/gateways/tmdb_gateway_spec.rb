require "rails_helper"

RSpec.describe TmdbGateway do
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
