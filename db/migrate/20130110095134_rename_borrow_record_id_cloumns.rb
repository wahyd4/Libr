class RenameBorrowRecordIdCloumns < ActiveRecord::Migration
  def up
	  remove_column :borrow_records, :book_id
	  remove_column :borrow_records, :user_id

	  add_column :borrow_records, :book_id, :integer
	  add_column :borrow_records, :user_id, :integer

  end

  def down
  end
end
