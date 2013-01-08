require "douban_auth"
class HomeController < ApplicationController
	 include Douban_Auth

	def index
		@books = Book.order 'id DESC'
	end

	def douban_callback

		 access_token params[:code]
		redirect_to '/'
	end
end
