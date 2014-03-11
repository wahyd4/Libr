class Api::V1::RegistrationsController < ApplicationController
  before_filter :allow_cors

  respond_to :json
  def create

    user = User.new(params[:user])
    if user.save
      render :json=> user.as_json(:auth_token=>user.auth_keys.last.value, :email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end

end
