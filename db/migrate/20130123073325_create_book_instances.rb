class CreateBookInstances < ActiveRecord::Migration
  def change
    create_table :book_instances do |t|
      t.integer :user_id ,:book_id
      t.boolean :public, default: true

      t.timestamps
    end
  end
end
