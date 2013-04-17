class BasicMessage < ActiveRecord::Base
  attr_accessible :to_user, :content, :create_time, :from_user, :message_id, :message_type ,:pic_url

end
