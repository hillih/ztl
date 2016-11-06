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

ActiveRecord::Schema.define(version: 20161105201845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choreographies", force: :cascade do |t|
    t.integer  "event_id",                           null: false
    t.integer  "outfit_category_id"
    t.string   "name"
    t.boolean  "artificial",         default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["event_id", "artificial"], name: "index_choreographies_on_event_id_and_artificial", unique: true, where: "(outfit_category_id IS NULL)", using: :btree
    t.index ["event_id", "outfit_category_id"], name: "index_choreographies_on_event_id_and_outfit_category_id", unique: true, where: "(outfit_category_id IS NOT NULL)", using: :btree
    t.index ["event_id"], name: "index_choreographies_on_event_id", using: :btree
    t.index ["outfit_category_id"], name: "index_choreographies_on_outfit_category_id", using: :btree
  end

  create_table "choreography_settings", force: :cascade do |t|
    t.integer  "outfit_element_type_id", null: false
    t.integer  "outfit_category_id"
    t.integer  "choreography_id",        null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["choreography_id"], name: "index_choreography_settings_on_choreography_id", using: :btree
    t.index ["outfit_category_id"], name: "index_choreography_settings_on_outfit_category_id", using: :btree
    t.index ["outfit_element_type_id", "outfit_category_id", "choreography_id"], name: "index_choreography_settings_on_id", unique: true, using: :btree
    t.index ["outfit_element_type_id"], name: "index_choreography_settings_on_outfit_element_type_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",                      null: false
    t.date     "start_at",                  null: false
    t.date     "end_at"
    t.boolean  "division",   default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "outfit_categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "outfit_element_type_id"
    t.string   "name",                                   null: false
    t.string   "symbol",                                 null: false
    t.string   "full_symbol"
    t.boolean  "last_category",          default: false
    t.boolean  "re_hire",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["outfit_element_type_id"], name: "index_outfit_categories_on_outfit_element_type_id", using: :btree
    t.index ["parent_id", "symbol"], name: "index_outfit_categories_on_parent_id_and_symbol", unique: true, using: :btree
    t.index ["parent_id"], name: "index_outfit_categories_on_parent_id", using: :btree
    t.index ["symbol"], name: "index_outfit_categories_on_symbol", unique: true, where: "(parent_id IS NULL)", using: :btree
  end

  create_table "outfit_element_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "symbol",     null: false
    t.integer  "sex",        null: false
    t.integer  "position",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sex", "position"], name: "index_outfit_element_types_on_sex_and_position", unique: true, using: :btree
    t.index ["symbol"], name: "index_outfit_element_types_on_symbol", unique: true, using: :btree
  end

  create_table "outfit_elements", force: :cascade do |t|
    t.integer  "outfit_category_id"
    t.string   "symbol"
    t.string   "full_symbol"
    t.string   "awf_code"
    t.boolean  "rented",             default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["outfit_category_id", "symbol"], name: "index_outfit_elements_on_outfit_category_id_and_symbol", unique: true, using: :btree
    t.index ["outfit_category_id"], name: "index_outfit_elements_on_outfit_category_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",                     null: false
    t.string   "symbol"
    t.text     "permissions", default: [],              array: true
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["symbol"], name: "index_roles_on_symbol", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "avatar"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "sex"
    t.integer  "role_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  add_foreign_key "choreographies", "events"
  add_foreign_key "choreographies", "outfit_categories"
  add_foreign_key "choreography_settings", "choreographies"
  add_foreign_key "choreography_settings", "outfit_categories"
  add_foreign_key "choreography_settings", "outfit_element_types"
  add_foreign_key "outfit_categories", "outfit_categories", column: "parent_id"
  add_foreign_key "outfit_categories", "outfit_element_types"
  add_foreign_key "outfit_elements", "outfit_categories"
  add_foreign_key "users", "roles"
end
