class Api::V1::LocationsController < ApplicationController

  before_filter :allow_cors
  before_filter :authenticate_user_from_token!, only: [:create, :index]

  def get_location
    lat = params[:lat]
    lng= params[:lng]
    map_service = MapService.new
    response = map_service.getLocation lat, lng
    render json: response
  end

  def create
    user = User.find_by_email params[:user_email]
    lat = params[:lat]
    lng= params[:lng]
    address = params[:address]
    location = user.locations.create lat: lat, lng: lng, address: address
    render json: location

  end

  def index
    user = User.find_by_email params[:user_email]
    render json: user.locations
  end

end
