class CreateBasicMessages < ActiveRecord::Migration
  def change
    create_table :basic_messages do |t|
      t.string :to_user
      t.string :from_user
      t.datetime :create_time
      t.string :message_type
      t.string :content
      t.integer :message_id, limit:8

      t.timestamps
    end
  end
end
