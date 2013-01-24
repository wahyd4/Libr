require 'spec_helper'

describe :User do
  before(:each) do
    @user = User.create name: 'Mary'
    @book = Book.create name:'See', image:'http:\/\/img3.douban.com\/mpic\/s24514758.jpg',isbn:'9787549529322'
  end

  describe 'user borrow a book' do
    it 'ensure user can"t borrow a book, when there is no book instance' do
       @user.borrow @book
       @user.books.empty?.should be_true
    end
    it 'ensure user can borrow a existed book'  do
      @book.book_instances.create user_id: @user.id
      @user.borrow @book
      @user.books.empty?.should be_false
    end
  end
end