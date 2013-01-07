class User < ActiveRecord::Base
  attr_accessible :email, :name, :books
	has_many :user_to_books
  has_many :books, through: :user_to_books
end
