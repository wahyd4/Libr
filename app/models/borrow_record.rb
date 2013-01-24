class BorrowRecord < ActiveRecord::Base
  attr_accessible :borrow_date, :return_date, :user_id, :book_instance_id

	belongs_to :user
	belongs_to :book_instance

	delegate :name, :avatar, to: :user,prefix: true

  def self.records_of(book)
    records = BorrowRecord.includes(:user).where("book_instance_id = ?", book.id).where(return_date:nil)
  end

  #def self.create_record(user_id,book_id)
  #  BorrowRecord.create user_id: user_id, book_id: book_id, borrow_date: DateTime.now
  #end

  def return_book
    update_attribute(:return_date,DateTime.now)
  end
end
