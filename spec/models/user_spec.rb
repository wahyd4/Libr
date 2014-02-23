require 'spec_helper'

describe :User do
  before(:each) do
    @user = User.create name: 'Mary', email: 'mary@qq.com', password: 'passworD1'
    @book = Book.create name: 'See', image: 'http:\/\/img3.douban.com\/mpic\/s24514758.jpg', isbn: '9787549529322'
  end

  describe 'user borrow a book' do

    it 'ensure user can borrow a existed book' do
      instance = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow instance
      @user.borrowed_and_not_returned_books.empty?.should be_false
      @user.borrowed_and_not_returned_books.count.should == 1
    end
    it 'ensure when there are two books,users can borrow these two books.' do
      user_1 = User.create name: 'Nick', email: 'a@a.com', password: 'passworD1'
      book_1 = Book.create name: 'Big data', image: 'none', isbn: '1234567890123'
      instance = BookInstance.create book_id: book_1.id, user_id: user_1.id
      instance_2 = BookInstance.create book_id: book_1.id, user_id: user_1.id
      user_1.borrowed_and_not_returned_books.count.should == 0
      user_1.borrow instance
      user_1.borrowed_and_not_returned_books.empty?.should be_false
      user_1.borrowed_and_not_returned_books.count.should == 1

    end

  end

  describe :borrowed_and_not_returned_books do
    it 'ensure return the book I borrowed and didn"t return back."' do
      instance = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow instance
      book_instances = @user.borrowed_and_not_returned_books
      book_instances.size.should == 1
      book_instances[0].should == instance

    end
  end

  describe :return_book do
    it 'ensure user return book,the borrowed books" count should decrease one"' do
      instance = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow instance
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
      User.create name: 'Testme', email: 'test@qq.com', password: 'passworD1'
      User.check_email_existed('test@qq.com').should be_true
    end
  end

  describe :generate_auth_key do
    it 'ensure generate a auth key for a user' do
      @user.auth_keys.count.should == 1
      lambda do
        @user.generate_auth_key
      end.should change(@user.auth_keys, :count).by(1)
      @user.auth_keys[0].value.size.should == 20
    end

  end

  describe :create_book_instance do
    it 'ensure create a book instance for a user' do
      # how to test with network ,mock
    end
  end

  describe :generate_authentication_token do
    it 'should generate a not nil token when create a user' do
      @user.auth_keys.empty?.should == false
      @user.auth_keys.size.should == 1
    end

  end

  describe :fetch_new_books do
    it 'should return user"s book after the one parsed to program' do
      book_one = @user.book_instances.create book_id: 1
      book_two = @user.book_instances.create book_id: 2
      book_three = @user.book_instances.create book_id: 3

      @user.fetch_new_books(2).count.should ==1
      @user.fetch_new_books(3).should == []


    end

  end
end