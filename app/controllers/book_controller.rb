class BookController < ApplicationController
	before_filter :current_user
  skip_before_filter :verify_authenticity_token ,:only => [:add_to_lib]

  def view
		@book = Book.find_by_id params[:id]
    @can_borrow = @book.users.count > @book.current_borrowers.count
    @records =BorrowRecord.records_of @book
    @borrowers = @book.borrowers
	end

	def search
		 unless params[:arg] == nil
			 @books = Book.where("name like ?","%#{params[:arg]}%")
			 render json: @books
		 else
			 render json: {msg:'wrong'}
		 end
  end

  def borrow
    unless @current_user
      redirect_to '/login',alert: "You need login to do the action."
      return
    end
    book = Book.find_by_id params[:id]
    puts "current======="+ book.current_borrowers.count.to_s
    puts "owner=======" +book.users.count.to_s
    if book.users.count <= book.current_borrowers.count
      @msg = 'Sorry, there is no more book for lend.'
    else
      #book.borrowers << @current_user
      @current_user.borrow book
      @msg = 'Borrowed success.'
    end
    redirect_to :back, notice: @msg
  end

  def new
     render :add
  end

  def add_to_lib
    unless @current_user
      redirect_to '/login',alert: "You need login to do the action."
      return
    end

    @current_user.books.create name:params[:title], image:params[:image],isbn: params[:isbn]
    @msg = 'This book has been succeed to add to library.'
    redirect_to :back, notice: @msg
  end
end
