class User < ActiveRecord::Base
  attr_accessible :email, :name, :avatar, :id

  validates_uniqueness_of :name


	has_many :book_instances

  has_many :borrow_records

  has_many :borrowed_books ,:source => :book_instance, through: :borrow_records


  def self.create_user(name,avatar)
		User.create name: name, avatar: avatar
  end

  def borrow(book)
    record = BorrowRecord.create user_id: self.id, book_instance_id: book.id, borrow_date: DateTime.now
    self.borrow_records << record


  end

  def borrowed_and_not_returned_books
    records = borrow_records.where(return_date: nil).order('id DESC')
    records.map{ |record| record = Book.find_by_id record.book_instance_id }

  end

  def books
    book_instances.order('id DESC').map{|instance| Book.find_by_id instance.book_id }
  end
end
