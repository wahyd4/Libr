require "douban_auth"

class HomeController < ApplicationController
	 include Douban_Auth
	 before_filter :current_user

	def index
		@books = Book.order 'id DESC'
	end

	def douban_callback

		token = access_token params[:code]
		user_info = fetch_user_info token
		sign_in(user_info['name'],user_info['avatar'])
		redirect_to '/'
	end

end
