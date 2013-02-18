class CreateAuthKeys < ActiveRecord::Migration
  def change
    create_table :auth_keys do |t|
      t.integer :user_id
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
