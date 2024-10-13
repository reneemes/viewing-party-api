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

    json = JSON.parse(response.body, symbolize_names: true)[:results]
    json.first(20)
  end

  def self.get_movie(movie_id)
    api_key = Rails.application.credentials.tmdb[:key]
    conn = Faraday.new(url: "https://api.themoviedb.org")

    response = conn.get("3/movie/#{movie_id}", {api_key: api_key})
    json = JSON.parse(response.body, symbolize_names: true)#[:results]
    # require 'pry'; binding.pry
  end
end
