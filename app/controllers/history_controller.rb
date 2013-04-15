class HistoryController < ApplicationController

  def index
    @records = BorrowRecord.order('id DESC').select { |record|
      BookInstance.find_by_id(record.book_instance_id) != nil
    }
    render :index
  end

  def records_for_user
    @user = User.find_by_id params[:user_id]
    @records = @user.borrow_records.order('id DESC').select { |record|
      BookInstance.find_by_id(record.book_instance_id) != nil
    }
    render :index
  end

end