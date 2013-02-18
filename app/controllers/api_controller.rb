class ApiController < ApplicationController

  def book_info
    book = Book.find_by_isbn params[:isbn]

    if book == nil
      render json: {book: nil, message: 'There is no mathched book.'}
      return
    end
    render json: book.to_json(include: [{:users => {except: [:api_key]}}, :available_instance])
  end

  def user_info
    user = User.find_by_id params[:user_id]

    if user == nil
      render json: {user: nil, message: 'There is no mathched user.'}
      return
    end
    render json: user.to_json(except: [:api_key, :created_at], include: [:books])
  end

  def books
    count = 10
    @books = Book.paginate(:page => params[:page], :per_page => count)
    params[:page] ? current_page = params[:page] : current_page = '1'
    render json: {books: @books, current_page: current_page, total_page: (Book.count / count) +1}
  end
end
