class RemoveApiKeyFromUser < ActiveRecord::Migration
  def up

    remove_column :users, :api_key
  end

  def down
  end
end
