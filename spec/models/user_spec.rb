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
      instance = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow @book
      @user.borrowed_and_not_returned_books.empty?.should be_false
      @user.borrowed_and_not_returned_books.count.should == 1
    end
    it 'ensure when there are two books,users can borrow these two books.' do
      user_1 = User.create name: 'Nick'
      book_1 = Book.create name: 'Big data',image:'none', isbn:'1234567890123'
      instance = BookInstance.create book_id: book_1.id, user_id: user_1.id
      instance_2 = BookInstance.create book_id: book_1.id, user_id: user_1.id
      user_1.borrowed_and_not_returned_books.count.should == 0
      user_1.borrow book_1
      user_1.borrowed_and_not_returned_books.empty?.should be_false
      user_1.borrowed_and_not_returned_books.count.should == 1

    end

  end

  describe :borrowed_and_not_returned_books do
    it 'ensure return the book I borrowed and didn"t return back."' do
      instance = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow @book
      book_instances = @user.borrowed_and_not_returned_books
      book_instances.size.should == 1
      book_instances[0].should == instance

    end
  end

  describe :return_book do
    it 'ensure user return book,the borrowed books" count should decrease one"' do
      instance = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow @book
      @user.return_book instance
      @user.borrowed_and_not_returned_books.count.should == 0
    end

  end

  describe :check_email_existed do
    it 'ensure return false when there is no user has a email equals test@qq.com' do
      @user.update_attributes email: 'test@gmail.com'
      User.check_email_existed('test@qq.com').should be_false
    end

    it 'ensure return true when there is someone has a email named test@qq.com' do
      User.create name:'Testme', email:'test@qq.com'
      User.check_email_existed('test@qq.com').should be_true
    end
  end
end