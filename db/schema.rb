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

ActiveRecord::Schema.define(version: 2021_08_18_074237) do

  create_table "cats", force: :cascade do |t|
    t.integer "resident_id", null: false
    t.text "address", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "image_id"
    t.text "detail", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "resident_id"
    t.integer "group_id"
    t.integer "cat_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faileds", force: :cascade do |t|
    t.integer "cat_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "postal_code", null: false
    t.text "address", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.boolean "withdrawal", default: false, null: false
    t.string "url", null: false
    t.text "explanation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_groups_on_email", unique: true
    t.index ["reset_password_token"], name: "index_groups_on_reset_password_token", unique: true
  end

  create_table "handles", force: :cascade do |t|
    t.integer "group_id"
    t.integer "cat_id", null: false
    t.integer "status", default: 0, null: false
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notices", force: :cascade do |t|
    t.integer "resident_send_id"
    t.integer "resident_receive_id"
    t.integer "group_send_id"
    t.integer "group_receive_id"
    t.integer "comment_id", null: false
    t.boolean "check", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "residents", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "postal_code", null: false
    t.text "address", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.boolean "withdrawal", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_residents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_residents_on_reset_password_token", unique: true
  end

end
