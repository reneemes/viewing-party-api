class Api::V1::MoviesController < ApplicationController
  def index
    begin
      best_movies = TmdbGateway.get_movies(params)
      render json: MovieSerializer.new(best_movies)
    rescue => error
      render json: ErrorSerializer.error(error.message), status: :service_unavailable
    end
  end

  def show
    begin
      id = params[:id]
      movie_info = TmdbGateway.get_movie_by_id(id)
      render json: MovieSerializer.format_one_movie(movie_info[:movie], movie_info[:cast], movie_info[:reviews])
    rescue => error
      render json: ErrorSerializer.error(error.message), status: :service_unavailable
    end
  end
end
