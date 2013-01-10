class BorrowRecord < ActiveRecord::Base
  attr_accessible :borrow_date, :return_date

	belongs_to :user
	belongs_to :book

	delegate :name, :avatar, to: :user,prefix: true
end
