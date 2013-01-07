class User < ActiveRecord::Base
  attr_accessible :email, :name, :books
	has_many :books
end
