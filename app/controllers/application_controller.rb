class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user!

  def current_user!
    @current_user = nil
    @current_user = current_user if user_signed_in?
  end

  def sign_in(name, avatar)
    if session[:name] == name
      return
    end
    unless User.find_by_name name
      User.create_user(name, avatar)
    end
    session[:name] = name
  end

  def same_user(controller)
    user = User.find_by_id params[:id]
    if user== nil || user!= @current_user
      redirect_to :root, notice: 'You do not have the right to see others keys.'
    end
  end

end
