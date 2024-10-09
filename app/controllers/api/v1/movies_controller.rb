class Api::V1::MoviesController < ApplicationController
  def index
    # api_key = Rails.application.credentials.tmdb[:key]

    # conn = Faraday.new(url: "https://api.themoviedb.org")

    # response = conn.get("3/movie/top_rated", {api_key: api_key})
   
    # json = JSON.parse(response.body, symbolize_names: true)[:results]

    # formatted_json = json.map do |movie|
    #   {
    #     "id": movie[:id],
    #     "type": "movie",
    #     "attributes": {
    #       "title": movie[:title],
    #       "vote_average": movie[:vote_average]
    #     }
    #   }
    # end

    # render json: { data: formatted_json }
    best_movies = Movie.top_rated_movies

    render json: MovieSerializer.new(best_movies)
  end
end