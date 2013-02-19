class AuthKeyController < ApplicationController

  before_filter { |controller| controller.same_user params[:id] }

  def index
    @keys = @current_user.auth_keys.order('id DESC')
    render :index
  end

  def new
    key = @current_user.generate_auth_key
    render json: key
  end

  def delete
    key = AuthKey.find_by_id params[:key_id]
    if key != nil && @current_user.auth_keys.include?(key)
      key.destroy
      msg = 'delete key success.'
      redirect_to :back, alert: msg
      return
    else
      msg = 'The key do not exit.'
      redirect_to :back, notice: msg
    end

  end


end
