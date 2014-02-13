class Api::V1::BooksController < ApplicationController

  before_filter :allow_cors
  before_filter :authenticate_user_from_token!

  def create

    book_info = Book.fetch_book_info_from_douban params[:isbn]
    if book_info['code'] == 6000
      render json: {status: 'error', message: 'ISBN is invalid, we can not find your book.'}
      return
    end
    user = User.find_by_email params[:user_email]
    instance = user.create_book_instance params[:isbn]
    render json: {status: 'success', book: instance.book}

  end

  def index
    user = User.find_by_email params[:user_email]
    count = 10
    @books = user.open_books.order('id DESC').paginate(:page => params[:page], :per_page => count)
    books = @books.map! { |book_instance| book_instance.book }
    params[:page] ? current_page = params[:page] : current_page = '1'
    render json: {books: books,
                  current_page: current_page,
                  total_page: total_page(user.open_books.count, count),
                  total_count: user.open_books.count}
  end

  def total_page(count, per_page)
    count%per_page == 0 ? count/per_page : (count/per_page) +1
  end

end
