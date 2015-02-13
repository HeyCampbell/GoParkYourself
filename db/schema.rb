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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20150213011523) do
=======


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

<<<<<<< HEAD
  create_table "signs", force: :cascade do |t|
    t.string   "status_order"
    t.integer  "sign_sequence"
    t.integer  "distance"
    t.string   "arrow"
    t.string   "sign_description"
    t.string   "parsed_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spots", force: :cascade do |t|
    t.string   "sign_id"
    t.integer  "user_id"
    t.datetime "parked_at"
    t.boolean  "remind?"
    t.datetime "expiration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "street_sections", force: :cascade do |t|
    t.string   "status_order"
    t.string   "main_street"
    t.string   "from_street"
    t.string   "to_street"
    t.string   "side_of_street"
    t.decimal  "latitude_from",  precision: 10, scale: 6
    t.decimal  "decimal",        precision: 10, scale: 6
    t.decimal  "longitude_from", precision: 10, scale: 6
    t.decimal  "latitude_to",    precision: 10, scale: 6
    t.decimal  "longitude_to",   precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end


end
