class AddMovieIdToParties < ActiveRecord::Migration[7.1]
  def change
    add_column :parties, :movie_id, :integer
  end
end
