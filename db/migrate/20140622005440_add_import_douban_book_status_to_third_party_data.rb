class AddImportDoubanBookStatusToThirdPartyData < ActiveRecord::Migration
  def change

    add_column :third_party_user_data, :import_douban_done, :boolean, default: false
  end
end
