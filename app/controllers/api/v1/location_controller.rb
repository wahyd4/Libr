class Api::V1::LocationController < ApplicationController

  before_filter :authenticate_user_from_token!, only: :new
  before_filter :allow_cors

  def get_location
    lat = params[:lat]
    lng= params[:lng]
    map_service = MapService.new
    response = map_service.getLocation lat, lng
    render json: response
  end

  def new
    user = User.find_by_email params[:user_email]
    lat = params[:lat]
    lng= params[:lng]
    location = user.locations.create lat: lat, lng: lng
    render json: location

  end

end
