class MovieSerializer
  include JSONAPI::Serializer
  # attributes :title, :vote_average
  set_type :movie

  set_id { |movie| movie[:id].to_s }

  attributes :title do |movie|
    movie[:title]
  end

  attributes :vote_average do |movie|
    movie[:vote_average]
  end


  def self.format_one_movie(movie, cast, review)
      {
          "data":
              {
              "id": movie[:id],
              "type": "movie",
              "attributes": {
                  "title": movie[:original_title],
                  "release_year": movie[:release_date][0..3],
                  "vote_average": movie[:vote_average],
                  "runtime": movie[:runtime],
                  "genres": [movie[:genres][:name]],
                  "summary": movie[:overview],
                  "cast": [
                    cast
                  ],
                  # "total_reviews": movie[:],
                  # "reviews": [
                  #   reviews
                  # ]
                  # ADD MORE TO THIS
                  }
              }
      }
    end

    def self.ten_actors(actor)
      {
        "character": actor[:character],
        "actor": actor[:name]
      }
    end

    def self.five_reviews(review)
      {
        "author": review[:author],
        "review": review[:content]
      }
    end
end

# set_id method
# def self.format_poster(poster)
#   {
#       "data":
#           {
#           "id": poster.id,
#           "type": "poster",
#           "attributes": {
#               "name": poster.name,
#               "description": poster.description,
#               "price": poster.price,
#               "year": poster.year,
#               "vintage": poster.vintage,
#               "img_url": poster.img_url
#               }
#           }
#   }
# end