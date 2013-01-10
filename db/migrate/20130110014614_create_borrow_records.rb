class CreateBorrowRecords < ActiveRecord::Migration
  def change
    create_table :borrow_records do |t|
      t.string :book_id
      t.string :user_id
      t.date :borrow_date
      t.date :return_date

      t.timestamps
    end
  end
end
