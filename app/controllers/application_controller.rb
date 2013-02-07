class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user

	def current_user
		@current_user = nil

		if session[:name]
			@current_user = User.find_by_name session[:name]
		end
	end

  def sign_in(name,avatar)
	  if session[:name] == name
		  return
	  end
	  unless User.find_by_name name
		  User.create_user(name,avatar)
    end
	  session[:name] = name
  end

end
