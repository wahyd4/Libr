class AddSortIdToBook < ActiveRecord::Migration
  def change

    add_column :books, :sort_id, :integer
  end
end
