require "douban_auth"
require "qq_auth"

class HomeController < ApplicationController
  include Douban_Auth
  include QQAuth
  before_filter :current_user

  def index
    @books = Book.order('id DESC').limit(20)
    @top_10_owners = BookInstance.select('user_id').group('user_id').order('count("user_id") DESC').limit(8).map! { |instance|
      User.find_by_id instance.user_id
    }
    @top_10_borrowers = BorrowRecord.select('user_id').group('user_id').order('count("user_id") DESC').limit(8).map! { |record|
      User.find_by_id record.user_id
    }

  end

  def douban_callback

    token = access_token params[:code]
    user_info = fetch_user_info token
    sign_in(user_info['name'], user_info['avatar'])
    redirect_to '/'
  end

  def qq_callback
    token = qq_auth_token params[:code]
    qq_openid = fetch_qq_open_id token
    user_info = fetch_qq_user_info token, qq_openid
    sign_in(user_info['nickname'], user_info['figureurl_1'])
    redirect_to '/'
  end
end
