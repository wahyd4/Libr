require 'utils'
class User < ActiveRecord::Base

  include Utils
  attr_accessible :email, :name, :avatar, :id, :location, :preferred_name, :api_key


  has_many :book_instances

  has_many :borrow_records

  has_many :borrowed_books, :source => :book_instance, through: :borrow_records


  def self.create_user(name, avatar)
    User.create name: name, avatar: avatar, api_key: Utils.random_key
  end

  def borrow(book)
    instance = book.available_instance
    unless instance == nil
      borrow_records.create user_id: id, book_instance_id: instance.id, borrow_date: DateTime.now
    end
  end

  def borrowed_and_not_returned_books
    records = borrow_records.where(return_date: nil).order('id DESC')
    records.map { |record| record = BookInstance.find_by_id record.book_instance_id }

  end

  def books
    book_instances
  end

  def return_book (instance)
    record = BorrowRecord.where(user_id: id, book_instance_id: instance.id, return_date: nil)[0]
    record.return_book
  end

  def update_preferred_name(name)
    update_attributes preferred_name: name
  end

  def update_email(email)
    update_attributes email: email
  end

  def update_location(location)
    update_attributes location: location
  end

  def self.check_email_existed(email)
    flag = false
    flag = true if User.find_by_email email
    flag
  end
end
