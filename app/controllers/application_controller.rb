class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user!

  #before_filter :authenticate_user_from_token!


  def current_user!
    @current_user = nil
    @current_user = current_user if user_signed_in?
  end

  #def sign_in(name, avatar)
  #  if session[:name] == name
  #    return
  #  end
  #  unless User.find_by_name name
  #    User.create_user(name, avatar)
  #  end
  #  session[:name] = name
  #end

  def same_user(controller)
    user = User.find_by_id params[:id]
    if user== nil || user!= @current_user
      redirect_to :root, notice: '你没有权限查看其他token'
    end
  end

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user = user_email && User.find_by_email(user_email)
    token = AuthKey.find_by_value params[:user_token]

    if user && user.auth_keys.include?(token)
      sign_in user, store: false
    else
      render :json => {:success => false, msg: 'token验证失败'}, status: :forbidden
    end
  end


  def allow_cors
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE HEAD}.join(",")
    headers["Access-Control-Allow-Headers"] = %w{Accept Accept-Language Content-Language Last-Event-ID Content-Type}.join(",")
    headers["Access-Control-Request-Method"] = "*"
    head(:ok) if request.request_method == " OPTIONS "
  end


end
