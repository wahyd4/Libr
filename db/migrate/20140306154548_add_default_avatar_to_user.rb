class AddDefaultAvatarToUser < ActiveRecord::Migration
  def change

    change_column :users, :avatar, :string, :default => "default.jpg"
  end
end
