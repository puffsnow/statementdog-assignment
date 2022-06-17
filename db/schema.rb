# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_17_090345) do

  create_table "detect_items", force: :cascade do |t|
    t.integer "detect_list_id"
    t.integer "stock_id"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["detect_list_id", "stock_id"], name: "index_detect_items_on_detect_list_id_and_stock_id", unique: true
    t.index ["detect_list_id"], name: "index_detect_items_on_detect_list_id"
    t.index ["stock_id"], name: "index_detect_items_on_stock_id"
  end

  create_table "detect_lists", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_detect_lists_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_sessions", force: :cascade do |t|
    t.integer "user_id"
    t.string "token", null: false
    t.datetime "expired_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "detect_items", "detect_lists"
  add_foreign_key "detect_items", "stocks"
  add_foreign_key "detect_lists", "users"
  add_foreign_key "user_sessions", "users"
end
