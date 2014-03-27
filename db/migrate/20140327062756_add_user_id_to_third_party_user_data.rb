class AddUserIdToThirdPartyUserData < ActiveRecord::Migration
  def change

    add_column :third_party_user_data, :user_id, :integer
  end
end
