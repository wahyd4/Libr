class ThirdPartyUserData < ActiveRecord::Base
  belongs_to :user
  attr_accessible :douban_user_name, :user_id


end
