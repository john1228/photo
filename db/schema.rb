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

ActiveRecord::Schema.define(version: 20150522102158) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "appoint_infos", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone"
    t.string   "baby_name"
    t.string   "baby_gender"
    t.string   "baby_birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bases", force: true do |t|
    t.string "name"
    t.string "address"
  end

  create_table "child_photos", force: true do |t|
    t.integer "child_star_id"
    t.string  "photo"
  end

  create_table "child_stars", force: true do |t|
    t.string  "name"
    t.string  "nickname"
    t.string  "country"
    t.integer "gender"
    t.string  "nation"
    t.integer "height"
    t.integer "weight"
    t.date    "birthday"
    t.string  "city"
    t.integer "price"
  end

  create_table "comment_images", force: true do |t|
    t.integer "comment_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "photographer_id"
    t.integer  "user_id"
    t.integer  "level"
    t.integer  "pro"
    t.integer  "att"
    t.integer  "pun"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "left_sides", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.string   "icon"
    t.string   "background"
    t.integer  "loc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "photographer_id"
    t.integer  "works_id"
    t.date     "appoint_date"
    t.integer  "appoint_time"
    t.string   "appoint_address"
    t.string   "contact"
    t.string   "phone"
    t.string   "baby_name"
    t.string   "baby_gender"
    t.string   "baby_birthday"
    t.string   "order_no"
    t.string   "coupons"
    t.string   "price"
    t.string   "pay_type"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photographers", force: true do |t|
    t.string   "name"
    t.string   "avatar"
    t.integer  "level"
    t.decimal  "price",      precision: 10, scale: 0
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resumes", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "city"
    t.integer  "exp"
    t.integer  "salary"
    t.integer  "opened"
    t.integer  "target"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "right_sides", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.string   "icon"
    t.string   "background"
    t.integer  "loc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "mobile"
    t.string   "sns"
    t.string   "password"
    t.string   "salt"
    t.string   "name"
    t.string   "avatar"
    t.integer  "gender"
    t.date     "birthday"
    t.string   "baby_name"
    t.integer  "baby_gender"
    t.date     "baby_birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", force: true do |t|
    t.integer  "photographer_id"
    t.string   "title"
    t.string   "works_type"
    t.integer  "during"
    t.decimal  "price",           precision: 10, scale: 0
    t.decimal  "discount",        precision: 10, scale: 0
    t.text     "intro"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "age"
  end

  create_table "works_photos", force: true do |t|
    t.integer "works_id"
    t.string  "photo"
    t.string  "photo_height"
  end

end
