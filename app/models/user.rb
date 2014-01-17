require 'utils'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :recoverable, :stretches => 20

  include Utils
  attr_accessible :email, :name, :avatar, :id, :location, :preferred_name


  has_many :book_instances

  has_many :borrow_records

  has_many :borrowed_books, :source => :book_instance, through: :borrow_records

  has_many :auth_keys


  def self.create_user(name, avatar)
    User.create name: name, avatar: avatar

  end

  def borrow(instance)
    unless instance == nil
      borrow_records.create user_id: id, book_instance_id: instance.id, borrow_date: DateTime.now
    end
  end

  def borrowed_and_not_returned_books
    records = borrow_records.where(return_date: nil).order('id DESC')
    records.map { |record| record = BookInstance.find_by_id record.book_instance_id }

  end

  def books
    book_instances.map { |instance| instance.book }
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

  def generate_auth_key
    auth_keys.create value: Utils.random_key, user_id: id
  end

  def create_book_instance(isbn, is_public = 'true')
    book = Book.find_by_isbn isbn
    unless  book
      book = Book.create_book_by_isbn isbn
    end
    instance = book.new_instance_for self

    if is_public == 'false'
      instance.be_private
    end

  end

  def open_books
    book_instances.where(public:true)
  end

  def private_books
    book_instances.where(public:false)
  end
end
