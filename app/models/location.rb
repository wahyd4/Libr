class Location < ActiveRecord::Base
  belongs_to :user

  attr_accessible :lng, :lat, :address, :user_id


  def locations_within_kilos_of(kilo)
    Location.all.keep_if { |location|
      GIS::Distance.new(self.lat, self.lng, location.lat, location.lng).distance <= kilo and location != self
    }
  end

  def users_within_kilos_of(kilo)
    locations_within_kilos_of(kilo).map { |location|
      location.user
    }
  end

end
