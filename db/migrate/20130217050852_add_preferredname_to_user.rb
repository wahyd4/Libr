class AddPreferrednameToUser < ActiveRecord::Migration
  def change
    add_column :users, :preferred_name, :string
  end
end
