class Movie < ApplicationRecord
  
  # def self.search(params)
  #   movies = Movie.all

  #   if param[:query]
  #     movies = self.search_by_title(movies, param[:query])
  #   end
  # end

  # # def self.top_rated_movies
  # #   api_key = Rails.application.credentials.tmdb[:key]

  # #   conn = Faraday.new(url: "https://api.themoviedb.org")

  # #   response = conn.get("3/movie/top_rated", {api_key: api_key})

  # #   json = JSON.parse(response.body, symbolize_names: true)[:results]

  # #   json.first(20)
  # # end

  # private

  # def self.search_by_title(movies, title)
  #   movies.where("name iLIKE ?", "%#{title}%")
  # end

end
