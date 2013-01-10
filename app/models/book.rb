class Book < ActiveRecord::Base
  attr_accessible :author, :image, :isbn, :name, :users

  has_many :user_to_books
	has_many :users, through: :user_to_books

	has_many :borrow_records
	has_many :borrowers,:source => :user, through: :borrow_records

end
