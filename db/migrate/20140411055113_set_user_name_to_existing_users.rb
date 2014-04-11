class SetUserNameToExistingUsers < ActiveRecord::Migration
  def change

    User.all.each { |user|
      unless user.name
        user.name = user.email.split('@')[0]
        user.save
      end
    }
  end
end
