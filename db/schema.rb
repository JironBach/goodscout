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

ActiveRecord::Schema.define(version: 20150721105605) do

  create_table "companies", force: :cascade do |t|
    t.string   "company_name",          limit: 255, null: false
    t.string   "email",                 limit: 255, null: false
    t.integer  "phone_number",          limit: 4
    t.string   "url",                   limit: 255
    t.string   "representative_person", limit: 255, null: false
    t.string   "accound_id",            limit: 255
    t.string   "encryped_password",     limit: 255
    t.integer  "status",                limit: 4,   null: false
    t.string   "address",               limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "engineer_skills", force: :cascade do |t|
    t.integer  "skills_id",           limit: 4, null: false
    t.integer  "engineer_id",         limit: 4, null: false
    t.integer  "years_of_experience", limit: 4, null: false
    t.integer  "level",               limit: 4, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "enginners", force: :cascade do |t|
    t.string   "name",                    limit: 255,                   null: false
    t.string   "email",                   limit: 255,                   null: false
    t.string   "encrypted_password",      limit: 255,                   null: false
    t.text     "self_introduction",       limit: 65535,                 null: false
    t.string   "living_place",            limit: 255
    t.string   "fb_uid",                  limit: 255
    t.string   "github_uid",              limit: 255
    t.integer  "age",                     limit: 4,                     null: false
    t.integer  "phone_number",            limit: 8
    t.integer  "status",                  limit: 4,     default: 0,     null: false
    t.text     "job_history",             limit: 65535,                 null: false
    t.text     "notes",                   limit: 65535
    t.boolean  "is_registration_enabled", limit: 1,     default: false, null: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.string   "title",        limit: 255,   null: false
    t.text     "desc",         limit: 65535, null: false
    t.integer  "how_to_reply", limit: 4,     null: false
    t.integer  "company_id",   limit: 4,     null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "from_type",  limit: 4,     null: false
    t.integer  "from_id",    limit: 4,     null: false
    t.integer  "to_id",      limit: 4,     null: false
    t.string   "title",      limit: 255,   null: false
    t.text     "desc",       limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
