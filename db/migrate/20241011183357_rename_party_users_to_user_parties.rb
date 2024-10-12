class RenamePartyUsersToUserParties < ActiveRecord::Migration[7.1]
  def change
    rename_table :party_users, :user_parties
  end
end
