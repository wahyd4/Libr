class BorrowRecord < ActiveRecord::Base
  attr_accessible :borrow_date, :return_date

	belongs_to :user
	belongs_to :book

	delegate :name, :avatar, to: :user,prefix: true

  def self.records_of(book)
    records = BorrowRecord.includes(:user).where("book_id = ?", book.id).where(borrow_date:nil)

    puts "xxxxxx" << records.to_s
    records
  end

  #def self.create_record(user_id,book_id)
  #  BorrowRecord.create user_id: user_id, book_id: book_id, borrow_date: DateTime.now
  #end
end
