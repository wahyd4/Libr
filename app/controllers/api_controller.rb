class ApiController < ApplicationController

  def book_info
    book = Book.find_by_isbn params[:isbn]

    if book == nil
      render json: {book: nil, message: 'There is no mathched book.'}
      return
    end
    render json: book.to_json(include: [{:users =>
                                             {except: [:api_key, :email, :created_at]}},
                                        :total_available_instances])
  end

  def user_info
    user = User.find_by_id params[:user_id]
    if user == nil
      render json: {user: nil, message: 'There is no mathched user.'}
      return
    end
    render json: user.to_json(except: [:api_key, :created_at, :email], include: [:books])
  end

  def books
    count = 10
    @books = Book.order('id DESC').paginate(:page => params[:page], :per_page => count)
    params[:page] ? current_page = params[:page] : current_page = '1'
    render json: {books: @books,
                  current_page: current_page,
                  total_page: total_page(Book.count, count),
                  total_count: Book.count}
  end

  def total_page(count, per_page)
    count%per_page == 0 ? count/per_page : (count/per_page) +1
  end

  def auth
    key = AuthKey.find_by_value params[:key].to_s.upcase
    user = nil
    if  key== nil || key.actived == true
      message = 'Sorry, The key is invalid,please change another one.'
      status = 'error'
    else
      key.active
      message = 'Authentication success.'
      user = key.user
      status = 'success'
    end
    render json: {user: user, message: message, status: status, key: params[:key]}
  end

  def search
    @books = Book.where('name ilike ?', "%#{params[:keyword]}%").limit(24)
    render json: {books: @books, total_count: @books.count}
  end

  def add_book
    key = AuthKey.find_by_value params[:key]
    unless key
      render json: {status: 'error', message: 'key is invalid,please change an other key.'}
      return
    end
    book_info = Book.fetch_book_info_from_douban params[:isbn]
    if book_info['code'] == 6000
      render json: {status: 'error', message: 'ISBN is invalid, we can not find your book.'}
      return
    end
    user = User.find_by_id key.user_id
    instance = user.create_book_instance params[:isbn]
    render json: {status: 'success', book: instance.book}

  end

  def borrow_book
    key = AuthKey.find_by_value params[:key]
    unless key
      render json: {status: 'error', message: 'key is invalid,please change an other key.'}
      return
    end
    instance = BookInstance.find_by_id params[:instance_id]
    if instance!=nil && instance.borrowed? != true
      user = User.find_by_id key.user_id
      user.borrow instance
      render json: {message: 'Borrow book success.', status: 'success'}
      return
    end
    render json: {message: 'Sorry, you can not borrow this book right now.', status: 'error'}
  end

  def return_book
    key = AuthKey.find_by_value params[:key]
    unless key
      render json: {status: 'error', message: 'key is invalid,please change an other key.'}
      return
    end
    instance = BookInstance.find_by_id params[:instance_id]
    user = User.find_by_id key.user_id
    if user.borrowed_and_not_returned_books.include? instance
      user.return_book instance
      render json: {message: 'Return book success.', status: 'success'}
      return
    end
    render json: {message: 'You do not borrowed this book  right now.', status: 'error'}
  end

end
