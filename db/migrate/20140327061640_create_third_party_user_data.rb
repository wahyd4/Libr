class CreateThirdPartyUserData < ActiveRecord::Migration
  def change
    create_table :third_party_user_data do |t|
      t.string :douban_user_name
      t.timestamps
    end
  end
end
