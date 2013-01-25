require "douban_auth"

class UserController < ApplicationController
  before_filter :current_user
	include Douban_Auth

	def login
		render :layout => false
	end

	def auth_douban
		url = auth_url.to_s
	  redirect_to url
	end

	def logout
		session[:name] = nil
		redirect_to '/'
  end

  def books
    query = params[:query]
    @user = User.find_by_id params[:id]
    case  query
      when 'borrowed'
        @books = @user.borrowed_and_not_returned_books
      when 'wanted'
        @books = nil
      else
        @books =  @user.books
    end
    @query = query
    render :books
  end

  def return_book
    records = BorrowRecord.where(user_id: params[:id],book_instance_id: params[:book_id],return_date: nil)
    unless records.empty?
      records[0].return_book
      @message = 'Return book success.'
    else
      @message = "Can't find your borrow record."
    end
    redirect_to :back,:notice => @message
  end

  def view

  end

end
