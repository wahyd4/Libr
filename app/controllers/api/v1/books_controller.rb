class Api::V1::BooksController < ApplicationController

  before_filter :allow_cors
  before_filter :authenticate_user_from_token!, except: :book_info
  skip_before_filter :verify_authenticity_token, :only => [:create, :import_douban_books]


  def create
    book_info = Book.find_book params[:isbn]
    if book_info['code'] == 6000
      render json: {status: 'error', message: 'ISBN 不存在，不能找到当前图书'}, status: :not_found
      return
    end
    user = User.find_by_email params[:user_email]
    instance = user.create_book_instance params[:isbn]
    if instance
      render json: {status: 'success', book: instance.sortable_book}, status: :ok
    else
      render json: {status: 'error', message: '请不要重复添加相同书籍'},status: :forbidden
    end
  end

  def index
    user = User.find_by_email params[:user_email]
    count = GlobalConstants::BOOKS_PER_PAGE_MOBILE
    @books = user.open_books.paginate(:page => params[:page], :per_page => count)
    books = @books.to_a.map! { |book_instance| book_instance.sortable_book }
    params[:page] ? current_page = params[:page] : current_page = '1'
    render json: {books: books,
                  current_page: current_page,
                  total_page: total_page(user.open_books.count, count),
                  total_count: user.open_books.count}
  end


  def total_page(count, per_page)
    count%per_page == 0 ? count/per_page : (count/per_page) +1
  end

  def book_info
    book = Book.find_book params[:isbn]
    if book == nil
      render json: {book: nil, message: '不同找到匹配的图书'}, status: :not_found
      return
    end
    render json: book.to_json(include: [{:users =>
                                             {except: [:api_key, :email, :created_at]}},
                                        :total_available_instances])
  end

  def fetch_new_books
    user = User.find_by_email params[:user_email]
    books = user.fetch_new_books params[:after_book_id]
    books = books.map! { |book_instance| book_instance.sortable_book }
    render json: {books: books}
  end

  def import_douban_books
    user = User.find_by_email params[:user_email]
    user.douban_user params[:name]
    render json: {status: 'success', msg: '成功连接豆瓣用户'}
  end

end
