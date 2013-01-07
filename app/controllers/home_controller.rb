class HomeController < ApplicationController

	def index
		@books = Book.order 'id DESC'
	end
end
