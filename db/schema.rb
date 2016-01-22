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

ActiveRecord::Schema.define(version: 20160122062300) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "appoint_infos", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "name",          limit: 255
    t.string   "phone",         limit: 255
    t.string   "baby_name",     limit: 255
    t.string   "baby_gender",   limit: 255
    t.string   "baby_birthday", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", force: :cascade do |t|
    t.integer "type",       limit: 4
    t.string  "image",      limit: 255
    t.string  "url",        limit: 255
    t.date    "start_date"
    t.date    "end_date"
  end

  create_table "bases", force: :cascade do |t|
    t.string "name",    limit: 255
    t.string "address", limit: 255
  end

  create_table "child_photos", force: :cascade do |t|
    t.integer "child_star_id", limit: 4
    t.string  "photo",         limit: 255
  end

  create_table "child_stars", force: :cascade do |t|
    t.string  "name",     limit: 255
    t.string  "nickname", limit: 255
    t.string  "country",  limit: 255
    t.integer "gender",   limit: 4
    t.string  "nation",   limit: 255
    t.integer "height",   limit: 4
    t.integer "weight",   limit: 4
    t.date    "birthday"
    t.string  "city",     limit: 255
    t.integer "price",    limit: 4
  end

  create_table "comment_images", force: :cascade do |t|
    t.integer "comment_id", limit: 4
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "photographer_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "level",           limit: 4
    t.integer  "pro",             limit: 4
    t.integer  "att",             limit: 4
    t.integer  "pun",             limit: 4
    t.text     "content",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "left_sides", force: :cascade do |t|
    t.integer  "city_id",    limit: 4
    t.string   "name",       limit: 255
    t.string   "icon",       limit: 255
    t.string   "background", limit: 255
    t.integer  "loc",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "photographer_id", limit: 4
    t.integer  "works_id",        limit: 4
    t.date     "appoint_date"
    t.integer  "appoint_time",    limit: 4
    t.string   "appoint_address", limit: 255
    t.string   "contact",         limit: 255
    t.string   "phone",           limit: 255
    t.string   "baby_name",       limit: 255
    t.string   "baby_gender",     limit: 255
    t.string   "baby_birthday",   limit: 255
    t.string   "order_no",        limit: 255
    t.string   "coupons",         limit: 255
    t.string   "price",           limit: 255
    t.string   "pay_type",        limit: 255
    t.integer  "status",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photographers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "avatar",     limit: 255
    t.integer  "level",      limit: 4
    t.decimal  "price",                  precision: 10
    t.string   "city",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resumes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "city",       limit: 255
    t.integer  "exp",        limit: 4
    t.integer  "salary",     limit: 4
    t.integer  "opened",     limit: 4
    t.integer  "target",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "right_sides", force: :cascade do |t|
    t.integer  "city_id",    limit: 4
    t.string   "name",       limit: 255
    t.string   "icon",       limit: 255
    t.string   "background", limit: 255
    t.integer  "loc",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "no",          limit: 255
    t.string   "order_no",    limit: 255
    t.string   "source",      limit: 255
    t.string   "buyer_id",    limit: 255
    t.string   "buyer_email", limit: 255
    t.decimal  "price",                   precision: 10
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "mobile",        limit: 255
    t.string   "sns",           limit: 255
    t.string   "password",      limit: 255
    t.string   "salt",          limit: 255
    t.string   "name",          limit: 255
    t.string   "avatar",        limit: 255
    t.integer  "gender",        limit: 4
    t.date     "birthday"
    t.string   "baby_name",     limit: 255
    t.integer  "baby_gender",   limit: 4
    t.date     "baby_birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", force: :cascade do |t|
    t.integer  "photographer_id", limit: 4
    t.string   "title",           limit: 255
    t.string   "works_type",      limit: 255
    t.integer  "during",          limit: 4
    t.decimal  "price",                         precision: 10
    t.decimal  "discount",                      precision: 10
    t.text     "intro",           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "age",             limit: 255
  end

  create_table "works_photos", force: :cascade do |t|
    t.integer "works_id",     limit: 4
    t.string  "photo",        limit: 255
    t.string  "photo_height", limit: 255
  end

end
