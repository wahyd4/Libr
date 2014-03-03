class Api::V1::CommentsController < ApplicationController

  before_filter :allow_cors
  before_filter :authenticate_user_from_token!, only: [:create]
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    book = Book.find_by_id params[:book_id]
    user = User.find_by_email params[:user_email]
    comment = Comment.build_from(book, user.id, params[:content])
    comment.save
    render json: {status: 'success', comment: comment}

  end

  def index
    book = Book.find_by_id params[:book_id]
    comments = book.comment_threads
    render json: comments
  end

end
