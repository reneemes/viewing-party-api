class CreatePartyUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :party_users do |t|
      t.references :party, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
