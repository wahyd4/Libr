class BookController < ApplicationController
	before_filter :current_user

  def view
		@book = Book.find_by_id params[:id]
    @can_borrow = @book.users.count > @book.borrowers.count
    @records =BorrowRecord.records_of @book
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
      redirect_to '/login',alert: "You need login to borrow book."
      return
    end
    book = Book.find_by_id params[:id]
    if book.users.count <= book.borrowers.count
      @msg = 'Sorry, there is no more book for lend.'
    else
      #book.borrowers << @current_user
      @current_user.borrow book
      @msg = 'Borrowed success.'
    end
    redirect_to :back, notice: 'Borrowed book success.'
  end
end
