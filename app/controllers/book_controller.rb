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
    book = Book.find_by_id params[:id]
    if book.users.count <= book.borrowers.count
      @msg = 'Sorry, there is no more book for lend.'
    else
      book.borrowers << @current_user
      @msg = 'Borrowed success.'
    end

    render json: @msg
  end
end
