class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :vote_average

  json.each do |movie|
    {
      "data": [
        {
          "id": movie.id
        }
      ]
    }
  end

  def self.format_movie_list(movies)
    { data:
        movies.map do |movie|
          {
            id: movie.id.to_s,
            type: "movie",
            attributes: {
              title: movie.title,
              vote_average: movie.vote_average
            }
          }
        end
    }
  end
end
