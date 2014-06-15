class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessible :email, :password, :password_confirmation

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


end

