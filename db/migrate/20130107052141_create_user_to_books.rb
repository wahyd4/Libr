class CreateUserToBooks < ActiveRecord::Migration
  def change
    create_table :user_to_books do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
