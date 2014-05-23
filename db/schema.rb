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

ActiveRecord::Schema.define(version: 20140522214639) do

  create_table "accounts", force: true do |t|
    t.string   "smid"
    t.integer  "user_id"
    t.boolean  "followed",        default: false
    t.boolean  "unfollowed",      default: false
    t.boolean  "followed_back",   default: false
    t.string   "parent"
    t.datetime "followed_date"
    t.datetime "unfollowed_date"
    t.string   "name"
    t.string   "handle"
    t.string   "image_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "batch_id"
    t.boolean  "mined"
    t.boolean  "following",       default: false
    t.string   "error"
  end

  add_index "accounts", ["smid", "user_id"], name: "index_accounts_on_smid_and_user_id", unique: true

  create_table "batches", force: true do |t|
    t.boolean  "unfollowed"
    t.datetime "unfollowed_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credentials", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mines", force: true do |t|
    t.integer  "user_id"
    t.boolean  "mined"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "smid"
    t.string   "handle"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
