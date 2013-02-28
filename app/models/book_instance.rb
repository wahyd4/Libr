class BookInstance < ActiveRecord::Base
  attr_accessible :book_id, :user_id, :public
  validates_presence_of :book_id, :user_id
  belongs_to :book
  belongs_to :user

  delegate :name, :image, :isbn, to: :book, prefix: false
  delegate :name, to: :user, prefix: true
  delegate :preferred_name, to: :user, prefix: true
  has_many :borrow_records
  has_many :borrowers, :source => :user, through: :borrow_records


  def borrowed?
    !borrow_records.where(return_date: nil).empty?
  end

  def current_borrower
    if borrowed?
      User.find_by_id borrow_records.where(return_date: nil)[0].user_id
    end
  end

  def change_to_private
     update_attribute :public, false
  end

end
