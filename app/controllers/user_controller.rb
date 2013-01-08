require "douban_auth"

class UserController < ApplicationController
	include Douban_Auth

	def login
		render :layout => false
	end

	def login_douban

		url = auth_url.to_s

		puts "xxxxxxxxxxxx"+url
	  redirect_to url
	end
end
