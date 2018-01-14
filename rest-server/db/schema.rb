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

ActiveRecord::Schema.define() do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", id: :serial, force: :cascade do |t|
    t.text "name"
    t.datetime "created_at"
    t.index ["name"], name: "groups_name"
  end

  create_table "groups_members", primary_key: ["group_id", "member_id"], force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "member_id", null: false
    t.boolean "admin", default: false
  end

  create_table "meetups", id: :serial, force: :cascade do |t|
    t.text "title", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "venue_id"
    t.integer "group_id"
    t.index ["title"], name: "meetups_title"
  end

  create_table "meetups_members", primary_key: ["meetup_id", "member_id"], force: :cascade do |t|
    t.integer "meetup_id", null: false
    t.integer "member_id", null: false
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.text "first_name"
    t.text "last_name"
    t.text "email"
    t.index ["email"], name: "members_email"
  end

  create_table "venues", id: :serial, force: :cascade do |t|
    t.text "name"
    t.text "postal_code"
    t.text "prefecture"
    t.text "city"
    t.text "street1"
    t.text "street2"
    t.integer "group_id"
    t.index ["name"], name: "venues_name"
  end

end
