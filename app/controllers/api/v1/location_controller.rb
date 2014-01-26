class Api::V1::LocationController < ApplicationController

  #before_filter :authenticate_user_from_token!

  def get_location
    lat = params[:lat]
    lng= params[:lng]
    map_service = MapService.new
    response = map_service.getLocation lat, lng
    render json: response
  end

end
