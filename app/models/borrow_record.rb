class BorrowRecord < ActiveRecord::Base
  attr_accessible :borrow_date, :return_date, :user_id, :book_instance_id
  validates_presence_of :user_id, :book_instance_id
  belongs_to :user
  belongs_to :book_instance

  delegate :name, :avatar, to: :user, prefix: true

  delegate :preferred_name, to: :user, prefix: true

  def self.records_of(book)
    total_records = []
    book.book_instances.each do |instance|
      records = BorrowRecord.includes(:user).where("book_instance_id = ?", instance.id).where(return_date: nil)
      total_records += records
    end
    total_records
  end

  #def self.create_record(user_id,book_id)
  #  BorrowRecord.create user_id: user_id, book_id: book_id, borrow_date: DateTime.now
  #end

  def return_book
    update_attribute(:return_date, DateTime.now)
  end
end
