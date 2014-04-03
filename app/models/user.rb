require 'utils'
class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :set_avatar, :set_preferred_name

  after_save :ensure_authentication_token

  has_many :third_party_user_datas

  include Utils
  attr_accessible :email, :name, :avatar, :id, :location, :preferred_name, :encrypted_password, :password,
                  :password_confirmation, :remember_me

  has_many :book_instances
  has_many :borrow_records
  has_many :borrowed_books, :source => :book_instance, through: :borrow_records
  has_many :auth_keys
  has_many :locations


  def ensure_authentication_token
    if auth_keys.empty?
      generate_auth_key
    end
  end

  def set_avatar
    self.avatar = Gravatar.new(self.email).image_url
  end

  def set_preferred_name
    self.preferred_name = email.split('@')[0]
  end


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

  def book_ids
    books.map { |book| book.id }
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
    AuthKey.create_key_for self
  end

  def create_book_instance(isbn, is_public = 'true')
    book = Book.find_book isbn
    if book.users.include? self
      return nil
    end
    instance = book.new_instance_for self
    if is_public == 'false'
      instance.be_private
    end
    instance
  end

  def open_books
    book_instances.where(public: true).order('id DESC')
  end

  def private_books
    book_instances.where(public: false)
  end

  def fetch_new_books(after_book_id)
    books_count = (GlobalConstants::BOOKS_PER_PAGE_MOBILE).to_i
    target_book_instance_id = (book_instances & BookInstance.where(book_id: after_book_id)).last.id

    books = self.book_instances.select { |instance|
      instance.id > target_book_instance_id
    }
    (books.count >books_count) ? books[1, books_count] : books

  end

  def avatar_url
    Gravatar.new(:email).image_url
  end


  def douban_user(name)
    if !third_party_user_datas.empty?
      user_data = third_party_user_datas.first
      user_data.douban_user_name = name
      user_data.save
    else
      third_party_user_datas.create douban_user_name: name
    end
    # Temp disabled
    DoubanBooksWorker.perform_async self, name
  end

end
