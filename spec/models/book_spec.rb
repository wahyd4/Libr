require 'spec_helper'

describe :Book do
  before(:each) do
    @book = Book.create name: 'Big Data'
    @user = User.create name: 'Mary'
    @instance = BookInstance.create book_id: @book.id, user_id: @user.id
  end
  describe :available_instance do
    it 'ensure reutrn a instance which did"t be borrowed.' do
      @book.available_instance.should ==  @instance
    end

    it 'when a book has two instances,ensure still one when another has been borrowed' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow @book
      @book.available_instance.should ==  instance_1
      @user.borrow @book
      @book.available_instance.should == nil
    end
  end

  describe :current_borrowers do
    it 'ensure when no one borrowed this book,the current_borrowers" count should be zero"' do
      @book.current_borrowers.count.should == 0
    end

    it 'ensure there should be one borrower' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow @book
      @book.current_borrowers.count.should == 1
      @book.current_borrowers[0].should == @user
    end
  end

  describe :toal_borrowers do
    it 'ensure current_borrowers count equals total_borrowers count,when there isn"t some return books "' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      @book.total_borrowers.count == 0
      @user.borrow @book
      @book.current_borrowers.count == 1
      @book.total_borrowers.count == 1
      @book.total_borrowers[0].name == @user.name

    end

    it 'ensure total_borrowers will count the user who returned the book' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      user_1 = User.create name:'Tom'
      @user.borrow @book
      user_1.borrow @book
      @user.return_book @instance
      @book.total_borrowers.count.should == 2
      @book.current_borrowers.count.should == 1
    end

  end


end