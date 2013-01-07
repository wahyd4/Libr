class UserToBook < ActiveRecord::Base

	attr_accessible :user, :book

	belongs_to :user
	belongs_to :book

end
