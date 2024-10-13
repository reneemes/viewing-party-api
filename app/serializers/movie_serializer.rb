class MovieSerializer
  include JSONAPI::Serializer
  set_type :movie
  set_id { |movie| movie[:id].to_s }

  attributes :title do |movie|
    movie[:title]
  end

  attributes :vote_average do |movie|
    movie[:vote_average]
  end


  def self.format_one_movie(movie, cast, review)
    generes = movie[:genres].map do |genre|
      genre[:name]
    end
    {
      "data":
        {
        "id": movie[:id].to_s,
        "type": "movie",
        "attributes": {
          "title": movie[:original_title],
          "release_year": movie[:release_date][0..3],
          "vote_average": movie[:vote_average],
          "runtime": format_runtime(movie[:runtime]),
          "genres": generes,
          "summary": movie[:overview],
          "cast": cast,
          "total_reviews": review.count,
          "reviews": review
          }
        }
      }
  end

  def self.ten_actors(cast)
    cast.map do |actor|
      {
        "character": actor[:character],
        "actor": actor[:name]
      }
    end
  end

  def self.five_reviews(reviews)
    reviews.map do |review|
      {
        "author": review[:author],
        "review": review[:content]
      }
    end
  end

  def self.format_runtime(runtime)
    hours = runtime / 60
    minutes = runtime % 60
    return "#{hours} hours, #{minutes} minutes"
  end

end
