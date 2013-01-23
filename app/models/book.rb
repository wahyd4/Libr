class Book < ActiveRecord::Base
  attr_accessible :author, :image, :isbn, :name, :users ,:id

  has_many :user_to_books
	has_many :users, through: :user_to_books

	has_many :borrow_records
	has_many :borrowers,:source => :user, through: :borrow_records

  def current_borrowers
    records = borrow_records.where(return_date: nil)
    records.map {|record| User.find_by_id record.user_id }
  end
end
