class ThirdPartyUserData < ActiveRecord::Base
  belongs_to :user
  attr_accessible :douban_user_name, :user_id, :import_douban_done

  def import_douban_user_done
    update_attributes import_douban_done: true
  end
end
