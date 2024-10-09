class Movie < ApplicationRecord
  
  def self.top_rated_movies
    api_key = Rails.application.credentials.tmdb[:key]

    conn = Faraday.new(url: "https://api.themoviedb.org")

    response = conn.get("3/movie/top_rated", {api_key: api_key})

    json = JSON.parse(response.body, symbolize_names: true)[:results]

    json.first(20)
  end

end
