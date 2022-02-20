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

ActiveRecord::Schema.define(version: 2022_02_20_231135) do

  create_table "clusters", force: :cascade do |t|
    t.string "name", limit: 30
    t.integer "organization_id", null: false
    t.integer "keyset_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["keyset_id"], name: "index_clusters_on_keyset_id"
    t.index ["organization_id"], name: "index_clusters_on_organization_id"
  end

  create_table "oidc_keys", force: :cascade do |t|
    t.integer "keyset_id"
    t.text "private_key"
    t.text "public_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "kid"
    t.string "type", default: "Oidc::Key::Db"
  end

  create_table "oidc_keysets", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "clusters", "organizations"
end
