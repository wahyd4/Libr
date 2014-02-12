class Api::V1::BooksController < ApplicationController

  before_filter :allow_cors
  before_filter :authenticate_user_from_token!

  def create
     puts "ss======="
    book_info = Book.fetch_book_info_from_douban params[:isbn]
    if book_info['code'] == 6000
      render json: {status: 'error', message: 'ISBN is invalid, we can not find your book.'}
      return
    end

    user = User.find_by_email params[:user_email]

    instance = user.create_book_instance params[:isbn]
    render json: {status: 'success', book: instance.book}


  end
end
