class RenameBookIdToBookInstanceId < ActiveRecord::Migration
  def up
    rename_column :borrow_records, :book_instance_id, :book_instance_id
  end

  def down
  end
end
