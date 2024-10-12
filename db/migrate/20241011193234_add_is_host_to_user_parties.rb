class AddIsHostToUserParties < ActiveRecord::Migration[7.1]
  def change
    add_column :user_parties, :is_host, :boolean
  end
end
