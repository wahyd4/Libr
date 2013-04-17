class AddPicUrlToBasicMessage < ActiveRecord::Migration
  def change
    add_column :basic_messages,:pic_url, :string
  end
end
