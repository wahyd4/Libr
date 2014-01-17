require 'spec_helper'

describe :Book do
  before(:each) do
    @book = Book.create name: 'taiwan', isbn: '9787563353484', image: 'http://img3.douban.com/mpic/s1327833.jpg'
    @user = User.create name: 'Mary'
    @instance = BookInstance.create book_id: @book.id, user_id: @user.id
  end
  describe :available_instance do
    it 'ensure reutrn a instance which did"t be borrowed.' do
      @book.available_instance.should == @instance
    end

    it 'when a book has two instances,ensure there is still one when another has been borrowed' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow @instance
      @book.available_instance.should == instance_1
      @user.borrow instance_1
      @book.available_instance.should == nil
    end
  end

  describe :current_borrowers do
    it 'ensure when no one borrowed this book,the current_borrowers" count should be zero"' do
      @book.current_borrowers.count.should == 0
    end

    it 'ensure there should be one borrower' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      @user.borrow @instance
      @book.current_borrowers.count.should == 1
      @book.current_borrowers[0].should == @user
    end
  end

  describe :toal_borrowers do
    it 'ensure current_borrowers count equals total_borrowers count,when there isn"t some return books "' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      @book.total_borrowers.count.should == 0
      @user.borrow instance_1
      @book.current_borrowers.count.should == 1
      @book.total_borrowers.count.should == 1
      @book.total_borrowers[0].name.should == @user.name

    end

    it 'ensure total_borrowers will count the user who returned the book' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      user_1 = User.create name: 'Tom', email: 'a@a.com'
      @user.borrow @instance
      user_1.borrow instance_1
      @user.should_not == nil
      @user.return_book @instance
      @book.total_borrowers.count.should == 2
      @book.current_borrowers.count.should == 1
    end

  end

  describe :total_available_instances do
    it 'ensure total available instance should be 1 after borrowed' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      @book.total_available_instances.count.should == 2
      @user.borrow instance_1
      @book.total_available_instances.count.should == 1
    end

    it 'ensure total available instances should be two when someone return back his borrowed books' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      @book.total_available_instances.count.should == 2
      @user.borrow instance_1
      @book.total_available_instances.count.should == 1
      @user.return_book instance_1
      @book.total_available_instances.count.should == 2
    end

    it 'ensure total available instance will not include the private book' do
      user_1 = User.create name: 'Nick', email: 'a@a.com'
      book_1 = Book.create name: 'Big data', image: 'none', isbn: '1234567890123'
      instance = BookInstance.create book_id: book_1.id, user_id: user_1.id
      instance_2 = BookInstance.create book_id: book_1.id, user_id: user_1.id
      instance.be_private
      temp_instance = BookInstance.find_by_id(instance.id)
      temp_instance.public.should be_false
      book_1.total_available_instances.include?(instance).should be_false
      book_1.total_available_instances.count.should == 1
    end

  end

  describe :open_owners do
    it 'ensure open users count should equals users count' do
       @book.open_owners.count.should == @book.users.count
    end

    it 'ensure open owners count should equals users count -1 ' do
      instance_1 = BookInstance.create book_id: @book.id, user_id: @user.id
      instance_1.be_private
      @book.open_owners.count.should == @book.users.count - 1
    end

  end


end