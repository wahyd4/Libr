class AddActivedToAuthkey < ActiveRecord::Migration
  def change
    add_column :auth_keys, :actived, :boolean, default: 'false'
  end
end
