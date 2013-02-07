require "douban_auth"
require "qq_auth"

class UserController < ApplicationController
  before_filter :current_user
  include Douban_Auth
  include QQAuth

  def login
    render :layout => false
  end

  def auth_douban
    url = auth_url.to_s
    redirect_to url
  end

  def auth_qq
    url = qq_auth_url.to_s
    redirect_to url
  end

  def logout
    session[:name] = nil
    redirect_to '/'
  end

  def books
    query = params[:query]
    @user = User.find_by_id params[:id]
    case query
      when 'borrowed'
        @books = @user.borrowed_and_not_returned_books
        puts "sssssss" +@books.size.to_s
      when 'wanted'
        @books = nil
      else
        @books = @user.books
    end
    @query = query
    render :books
  end

  def return_book
    instance = BookInstance.find_by_id params[:instance_id]
    if @current_user.borrowed_and_not_returned_books.include? instance
      @current_user.return_book instance
      @message = 'Return book success.'
      redirect_to :back, :alert => @message
      return
    else
      @message = "Can't find your borrow record."
    end
    redirect_to :back, :notice => @message
  end

  def view
    @user = User.find_by_id params[:id]

    @total_borrowed_books = @user.borrowed_books
    @total_books = @user.book_instances
  end

  def delete_book

    user = User.find_by_id params[:user_id]
    if user != @current_user
      @message = "error,illagle."
      redirect_to :back, :notice => @message
      return
    end

    instance = BookInstance.find_by_id params[:instance_id]

    if instance.current_borrower !=nil
      @message = "This book can't be delete, because there is still have a borrower"
      redirect_to :back, :notice => @message
      return
    end

    if instance != nil && user.book_instances.include?(instance)
      @current_user.book_instances.destroy instance
      @message = "delete book success"
      redirect_to :back, :alert => @message
    end
  end

end
