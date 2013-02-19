require 'utils'
class AuthKey < ActiveRecord::Base
  include Utils
  attr_accessible :name, :user_id, :value, :actived

  validates_presence_of :value, :user_id, message: 'cannot be blank.'
  validates_uniqueness_of :value, message: 'must be unique.'
  belongs_to :user

  def self.create_key_for(user)
    AuthKey.create value: Utils.random_key, user_id: user.id
  end
end
