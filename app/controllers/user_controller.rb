require "douban_auth"

class UserController < ApplicationController
	include Douban_Auth

	def login
		render :layout => false
	end

	def auth_douban
		url = auth_url.to_s
	  redirect_to url
	end

	def logout
		session[:name] = nil
		redirect_to '/'
	end

end
