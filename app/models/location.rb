class Location < ActiveRecord::Base
  belongs_to :user

  attr_accessible :lng, :lat, :address

end
