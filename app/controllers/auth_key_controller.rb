class AuthKeyController < ApplicationController

  before_filter {|controller| controller.same_user params[:id] }

  def index
    @keys = @current_user.auth_keys.order('id DESC')
    render :index
  end

  def new
    key = @current_user.generate_auth_key
    render json: key
  end
end
