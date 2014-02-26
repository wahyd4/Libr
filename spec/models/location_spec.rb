require 'spec_helper'

describe Location do

  before(:each) do
    @user = User.create name: 'Mary', email: 'mary@qq.com', password: 'passworD1'
    @location = Location.create lat: 40.47, lng: 73.58, user_id: @user.id
    Location.create lat: 34.3, lng: 118.15, user_id: @user.id
  end


  describe 'location' do

    it 'should return empty array' do
      locations = @location.locations_within_kilos_of(5)
      locations.size.should == 0
    end

    it 'should return an array with one item' do

      locations = @location.locations_within_kilos_of(4000)
      locations.size.should == 1

    end

  end

end
