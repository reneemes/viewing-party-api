# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
danny = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "jerseyMikesRox7")
dolly = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")
User.create!(name: "Lionel Messi", username: "futbol_geek", password: "test123")

Party.create!(name: "Watch Party!",
              start_time: "2025-02-01 10:00:00",
              end_time: "2025-02-01 14:30:00",
              movie_id: 278,
              movie_title: "The Shawshank Redemption",
              api_key: dolly.api_key,
              invitees: [danny.id])