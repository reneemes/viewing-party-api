class RenameUsersIdToUserIdInUserParties < ActiveRecord::Migration[7.1]
  def change
    rename_column :user_parties, :users_id, :user_id
  end
end
