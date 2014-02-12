class AddSomeAttributesToBook < ActiveRecord::Migration
  def change
    add_column :books, :publisher, :string
    add_column :books, :price, :string
    add_column :books, :sub_title, :string
    add_column :books, :pages, :string
    add_column :books, :image_large, :string
    add_column :books, :translators, :string
    add_column :books, :publish_date, :string
  end
end
