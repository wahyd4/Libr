class Book < ActiveRecord::Base
  attr_accessible :author, :image, :isbn, :name, :users

	has_many :users
end
