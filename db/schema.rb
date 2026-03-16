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

ActiveRecord::Schema[8.1].define(version: 2026_03_16_151457) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "account_guest_categories", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "name"], name: "index_account_guest_categories_on_account_id_and_name"
    t.index ["account_id"], name: "index_account_guest_categories_on_account_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guest_categories", force: :cascade do |t|
    t.bigint "account_guest_category_id", null: false
    t.datetime "created_at", null: false
    t.bigint "guest_id", null: false
    t.datetime "updated_at", null: false
    t.index ["account_guest_category_id"], name: "index_guest_categories_on_account_guest_category_id"
    t.index ["guest_id", "account_guest_category_id"], name: "idx_on_guest_id_account_guest_category_id_a4f936f12c"
    t.index ["guest_id"], name: "index_guest_categories_on_guest_id"
  end

  create_table "guests", force: :cascade do |t|
    t.integer "age_group"
    t.datetime "created_at", null: false
    t.string "first_name", null: false
    t.integer "guest_of"
    t.string "last_name", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "account_guest_categories", "accounts"
  add_foreign_key "guest_categories", "account_guest_categories"
  add_foreign_key "guest_categories", "guests"
end
