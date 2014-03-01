class Book < ActiveRecord::Base
  attr_accessible :author, :image, :isbn, :name, :id, :publisher, :price, :sub_title,
                  :pages, :image_large, :translators, :publish_date, :sort_id

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

  def total_available_instances
    instances = []
    book_instances.each { |instance|
      instances << instance if  instance.public && !instance.borrowed?
    }
    instances
  end

  def new_instance_for(user)
    book_instances.create user_id: user.id, book_id: id
  end

  def self.create_book_by_isbn(book_info)
    Book.create name: book_info['title'],
                image: book_info['image'],
                isbn: book_info['isbn13'],
                author: book_info['author'][0],
                publisher: book_info['publisher'],
                price: book_info['price'],
                sub_title: book_info['subtitle'],
                pages: book_info['pages'],
                image_large: book_info['images']['large'],
                publish_date: book_info['pubdate']

  end

  def self.fetch_book_info_from_douban(isbn)
    http = Net::HTTP.new('api.douban.com', 443)
    http.use_ssl = true
    path ='/v2/book/isbn/' + isbn
    response = http.get(path)
    book_info = JSON.parse response.body
    if book_info['code'] == 6000
      book_info
    else
      self.create_book_by_isbn book_info
    end
  end

  def self.find_book(isbn)
    book = Book.find_by_isbn isbn
    book ? book : Book.fetch_book_info_from_douban(isbn)

  end

  def open_owners
    total_available_instances.map { |instance| instance.user }
  end


end
