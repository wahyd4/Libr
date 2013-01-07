class BookController < ApplicationController

	def view
		@book = Book.find_by_id params[:id]
	end

	def search
		 unless params[:arg] == nil
			 @books = Book.where("name like ?","%#{params[:arg]}%")
			 render json: @books
		 else
			 render json: {msg:'wrong'}
		 end

	end
end
