class SearchController < ApplicationController

  def do_search
    @books = Book.where('name ilike ?',"%#{params[:keyword]}%").limit(24)
    render :view
  end
end
