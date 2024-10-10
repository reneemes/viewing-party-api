class Api::V1::MoviesController < ApplicationController
  def index
    api_key = Rails.application.credentials.tmdb[:key]
    conn = Faraday.new(url: "https://api.themoviedb.org")

    if params[:query].present?
    #   # use a helper method in the model
      response = conn.get("3/search/movie", {api_key: api_key, query: params[:query]})
    else
      response = conn.get("3/movie/top_rated", {api_key: api_key})
    end

    # response = conn.get("3/movie/top_rated", {api_key: api_key})

    if !response.success?
      return render json: {
        error: "Cannot connect to The Movie Database."
      }, status: :bad_request
    end
   
    json = JSON.parse(response.body, symbolize_names: true)[:results]
    best_movies = json.first(20)

    render json: MovieSerializer.new(best_movies)
  end

  def show
    movie = params[:title]

    conn = Faraday.new(url: "https://api.themoviedb.org")# do |faraday|
    #   faraday.headers["Authorization"] = Rails.application.credentials.pexels[:key]
    # end

    # response = conn.get("/v1/search", { query: artist })
    response = conn.get("3/search/movie", {api_key: api_key, query: movie})
    # OR response = conn.get("/v1/search?query=#{artist})

    json = JSON.parse(response.body, symbolize_names: true)
    first_photo = json[:photos][0]

    formatted_json = {
      id: nil,
      type: "image",
      attributes: {
        image_url: first_photo[:url],
        photographer: first_photo[:photographer],
        photographer_url: first_photo[:photographer_url],
        alt_text: first_photo[:alt]
      }
    }

    render json: { data: formatted_json }
  end
end

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
    # best_movies = Movie.top_rated_movies