class TmdbGateway
  def self.get_movies(params)
    api_key = Rails.application.credentials.tmdb[:key]
    conn = Faraday.new(url: "https://api.themoviedb.org")

    if params[:query]
      search = params[:query].downcase
      response = conn.get("3/search/movie", {api_key: api_key, query: search})
    else
      response = conn.get("3/movie/top_rated", {api_key: api_key})
    end

    if response.status != 200
      raise "Unable to fetch movies from the external API."
    end

    json = JSON.parse(response.body, symbolize_names: true)[:results]
    json.first(20)
  end

  def self.get_movie_by_id(id)
    api_key = Rails.application.credentials.tmdb[:key]
    conn = Faraday.new(url: "https://api.themoviedb.org")


    movie_response = conn.get("3/movie/#{id}", {api_key: api_key})
    movie = JSON.parse(movie_response.body, symbolize_names: true)


    cast_response = conn.get("3/movie/#{id}/credits", {api_key: api_key})
    cast = JSON.parse(cast_response.body, symbolize_names: true)[:cast].first(10)
    cast_data = MovieSerializer.ten_actors(cast)


    reviews_response = conn.get("3/movie/#{id}/reviews", {api_key: api_key})
    reviews = JSON.parse(reviews_response.body, symbolize_names: true)[:results].first(5)
    review_data = MovieSerializer.five_reviews(reviews)

    { movie: movie, cast: cast_data, reviews: review_data}
  end

  def self.get_movie(movie_id)
    api_key = Rails.application.credentials.tmdb[:key]
    conn = Faraday.new(url: "https://api.themoviedb.org")

    response = conn.get("3/movie/#{movie_id}", {api_key: api_key})
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
