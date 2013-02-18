class Book < ActiveRecord::Base
  attr_accessible :author, :image, :isbn, :name, :id
  validates_presence_of :image, :isbn, :name, message: 'cannot be blank.'
  validates_uniqueness_of :isbn, :image, message: 'should be unique.'

  has_many :book_instances
  has_many :users, through: :book_instances

  def current_borrowers
    borrowers = []
    book_instances.each { |instance|
      if instance.borrowed?
        borrowers << instance.current_borrower
      end
    }
    borrowers
  end

  def total_borrowers
    borrowers = []
    book_instances.each { |instance|
      unless  instance.borrowers.empty?
        borrowers += instance.borrowers
      end
    }
    borrowers
  end

  def available_instance
    avail_instance = nil
    book_instances.each do |instance|
      unless instance.borrowed?
        avail_instance = instance
        break
      end
    end
    avail_instance
  end

  def new_instance_for(user)
    book_instances.create user_id: user.id, book_id: id
  end

end
