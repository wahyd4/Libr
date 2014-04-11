class Api::V1::RecommendController < ApplicationController

  before_filter :allow_cors
  before_filter :authenticate_user_from_token!

  def popular_books_around_me
    user = User.find_by_email params[:user_email]
    location = Location.find_by_id params[:location_id]
    if location == nil or !user.locations.include? location
      render json: {status: 'error', message: '不能找到当前地点'}
      return
    end
    users = location.users_within_kilos_of 10
    recommend_service = RecommendService.new
    books = recommend_service.sort_users_books_by_popularity users
    render json: books
  end

  def recommend_books_by_similarity_for_me
    user = User.find_by_email params[:user_email]
    recommend_service = RecommendService.new
    books = recommend_service.recommend_books_by_similarity user
    render json: books
  end

end
