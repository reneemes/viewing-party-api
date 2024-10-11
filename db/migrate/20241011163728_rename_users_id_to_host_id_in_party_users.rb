class RenameUsersIdToHostIdInPartyUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :party_users, :users_id, :host_id
    
    # remove_foreign_key :party_users, :users, column: :users_id

    add_foreign_key :party_users, :users, column: :host_id
  end
end
