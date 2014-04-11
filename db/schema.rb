# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140411055113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_keys", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "actived",    default: false
  end

  create_table "basic_messages", force: true do |t|
    t.string   "to_user"
    t.string   "from_user"
    t.datetime "create_time"
    t.string   "message_type"
    t.string   "content"
    t.integer  "message_id",   limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_url"
  end

  create_table "book_instances", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.boolean  "public",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "isbn"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "publisher"
    t.string   "price"
    t.string   "sub_title"
    t.string   "pages"
    t.string   "image_large"
    t.string   "translators"
    t.string   "publish_date"
    t.integer  "sort_id"
  end

  create_table "borrow_records", force: true do |t|
    t.date     "borrow_date"
    t.date     "return_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_instance_id"
    t.integer  "user_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "commentable_id",   default: 0
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          default: 0, null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "locations", force: true do |t|
    t.integer  "user_id"
    t.float    "lat"
    t.float    "lng"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "third_party_user_data", force: true do |t|
    t.string   "douban_user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "user_to_books", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",            null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",                 default: "default.jpg"
    t.string   "location"
    t.string   "preferred_name"
    t.string   "encrypted_password",     default: "",            null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,             null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
