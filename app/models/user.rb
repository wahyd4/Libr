class User < ActiveRecord::Base
  attr_accessible :email, :name, :books, :avatar, :id

  validates_uniqueness_of :name


	has_many :user_to_books
  has_many :books, through: :user_to_books

  has_many :borrow_records
  has_many :borrowed_books ,:class_name => 'Book',:source => :book, through: :borrow_records


	def self.create_user(name,avatar)
		User.create name: name, avatar: avatar
  end

  def borrow(book)
    record = BorrowRecord.create user_id: self.id, book_id: book.id, borrow_date: DateTime.now
    self.borrow_records << record
  end

  def borrowed_and_not_returned_books
    records = borrow_records.where(return_date: nil).order('id DESC')
    records.map{ |record| record = Book.find_by_id record.book_id }

  end
end
