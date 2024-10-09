class MovieSerializer
  include JSONAPI::Serializer
  # attributes :title, :vote_average
  set_type :movie
  # set_id :id #optional

  set_id { |movie| movie[:id].to_s }


  attributes :title do |movie|
    movie[:title]
  end

  attributes :vote_average do |movie|
    movie[:vote_average]
  end

  # json.each do |movie|
  #   {
  #     "data": [
  #       {
  #         "id": movie.id
  #       }
  #     ]
  #   }
  # end

  # def self.format_movie_list(movies)
  #   { data:
  #       movies.map do |movie|
  #         {
  #           id: movie.id.to_s,
  #           type: "movie",
  #           attributes: {
  #             title: movie.title,
  #             vote_average: movie.vote_average
  #           }
  #         }
  #       end
  #   }
  # end
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