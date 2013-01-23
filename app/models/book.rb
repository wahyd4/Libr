class Book < ActiveRecord::Base
  attr_accessible :author, :image, :isbn, :name ,:id

  has_many :book_instances
  has_many :users, through: :book_instances

  def current_borrowers
    borrowers = []
    book_instances.each{|instance|
      if instance.borrowed?
        borrowers << instance.current_borrower
      end
    }
    borrowers
  end

  def total_borrowers
     borrowers = []
     book_instances.map{|instance|
       unless  instance.borrowers.empty?
         borrowers << instance.borrowers
       end
     }
  end

end
