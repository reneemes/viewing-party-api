class Api::V1::MoviesController < ApplicationController
  def index
    best_movies = TmdbGateway.get_movies(params)
    render json: MovieSerializer.new(best_movies)
  end

  # def show
  #   id = params[:id]
  #   api_key = Rails.application.credentials.tmdb[:key]
  #   conn = Faraday.new(url: "https://api.themoviedb.org")

  #   # https://api.themoviedb.org/3/movie/122?api_key=123

  #   movie_response = conn.get("3/movie/#{id}", {api_key: api_key})
  #   movie = JSON.parse(movie_response.body, symbolize_names: true)

  #   # https://api.themoviedb.org/3/movie/122/credits?api_key=123

  #   cast_response = conn.get("3/movie/#{id}/credits", {api_key: api_key})
  #   cast = JSON.parse(cast_response.body, symbolize_names: true).first(10)
  #   cast_data = MovieSerializer.ten_actors(cast)

  #   # https://api.themoviedb.org/3/movie/122/reviews?api_key=123

  #   reviews_response = conn.get("3/movie/#{id}/reviews", {api_key: api_key})
  #   reviews = JSON.parse(reviews_response.body, symbolize_names: true).first(5)
  #   review_data = MovieSerializer.five_reviews(reviews)

  #   render json: MovieSerializer.format_one_movie(movie, cast_data, review_data)
  # end
end
