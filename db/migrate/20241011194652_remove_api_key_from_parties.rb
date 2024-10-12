class RemoveApiKeyFromParties < ActiveRecord::Migration[7.1]
  def change
    remove_column :parties, :api_key
  end
end
