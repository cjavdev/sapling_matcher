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

ActiveRecord::Schema.define(version: 20150131220949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.boolean "current"
    t.string  "title"
    t.string  "company"
    t.string  "description"
    t.date    "start_date"
    t.date    "end_date"
    t.string  "linkedin_company_url"
    t.string  "name"
    t.integer "linkedin_profile_id"
    t.string  "url"
    t.string  "website"
    t.string  "industry"
    t.string  "headquarters"
    t.string  "company_size"
    t.string  "founded"
    t.string  "address"
  end

  add_index "companies", ["linkedin_profile_id"], name: "index_companies_on_linkedin_profile_id", using: :btree

  create_table "linkedin_profiles", force: :cascade do |t|
    t.string   "link",                         null: false
    t.boolean  "advisor",      default: false
    t.string   "first_name"
    t.string   "last_name"
    t.text     "summary"
    t.text     "page"
    t.string   "picture"
    t.string   "title"
    t.string   "industry"
    t.string   "linkedin_url"
    t.string   "location"
    t.string   "country"
    t.string   "client_type"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "linkedin_profiles", ["link"], name: "index_linkedin_profiles_on_link", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.string  "period"
    t.integer "linkedin_profile_id"
  end

  add_index "schools", ["linkedin_profile_id"], name: "index_schools_on_linkedin_profile_id", using: :btree

  create_table "websites", force: :cascade do |t|
    t.string  "name"
    t.integer "linkedin_profile_id"
  end

  add_index "websites", ["linkedin_profile_id"], name: "index_websites_on_linkedin_profile_id", using: :btree

end
