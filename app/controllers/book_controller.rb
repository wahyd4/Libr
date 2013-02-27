class BookController < ApplicationController
  before_filter :current_user
  skip_before_filter :verify_authenticity_token, :only => [:add_to_lib]

  def view
    @book = Book.find_by_id params[:id]
    @can_borrow = @book.book_instances.count > @book.current_borrowers.count
    @records =BorrowRecord.records_of @book
    @borrowers = @book.total_borrowers.uniq
    @owners = @book.users
    @available_instances = @book.total_available_instances
  end

  def search
    unless params[:arg] == nil
      @books = Book.where("name like ?", "%#{params[:arg]}%")
      render json: @books
    else
      render json: {msg: 'error'}
    end
  end

  def borrow
    unless @current_user
      redirect_to '/login', notice: 'You need login to do the action.'
      return
    end
    #book = Book.find_by_id params[:id]
    #if book.users.count <= book.current_borrowers.count
    #  @msg = 'Sorry, there is no more book for lend.'
    #else
    #  #book.borrowers << @current_user
    #  @current_user.borrow book
    #  @msg = 'Borrowed success.'
    #end
    instance = BookInstance.find_by_id params[:instance_id].to_s
    @current_user.borrow instance
    redirect_to :back, alert: 'Borrow book success.'
  end

  def new
    render :add
  end

  def add_to_lib
    unless @current_user
      redirect_to '/login', notice: 'You need login to do the action.'
      return
    end
    @current_user.create_book_instance params[:isbn]
    @msg = 'This book has been succeed to add to library.'
    redirect_to :back, alert: @msg
  end

  def list
    @books = Book.order('id DESC').paginate(:page => params[:page], :per_page => 24)
    render :index
  end
end
