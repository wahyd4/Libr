require "douban_auth"

class UserController < ApplicationController
  before_filter :current_user
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

  def owned_books
    @books =  @current_user.books.order 'id DESC'
    render 'home/index'
  end

end
