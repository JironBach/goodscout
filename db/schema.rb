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

ActiveRecord::Schema.define(version: 20150817055819) do

  create_table "companies", force: :cascade do |t|
    t.string   "name",                  limit: 255, null: false
    t.string   "email",                 limit: 255, null: false
    t.string   "password_digest",       limit: 255
    t.string   "phone_number",          limit: 255
    t.string   "url",                   limit: 255
    t.string   "image",                 limit: 255
    t.string   "representative_person", limit: 255, null: false
    t.string   "encryped_password",     limit: 255
    t.integer  "status",                limit: 4,   null: false
    t.string   "address",               limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "desire_to_works", force: :cascade do |t|
    t.string   "desc",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "engineer_skills", force: :cascade do |t|
    t.integer  "skill_id",            limit: 4, null: false
    t.integer  "engineer_id",         limit: 4
    t.integer  "years_of_experience", limit: 4, null: false
    t.integer  "level",               limit: 4, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "engineer_skills", ["engineer_id"], name: "index_engineer_skills_on_engineer_id", using: :btree

  create_table "engineers", force: :cascade do |t|
    t.string   "name",                  limit: 255,                  null: false
    t.string   "email",                 limit: 255,                  null: false
    t.string   "image",                 limit: 255
    t.string   "password_digest",       limit: 255,                  null: false
    t.text     "self_introduction",     limit: 65535,                null: false
    t.string   "living_place",          limit: 255
    t.string   "fb_uid",                limit: 255
    t.string   "fb_url",                limit: 255
    t.string   "github_uid",            limit: 255
    t.string   "github_url",            limit: 255
    t.integer  "age",                   limit: 4,                    null: false
    t.string   "phone_number",          limit: 255
    t.text     "job_history",           limit: 65535,                null: false
    t.integer  "job_id",                limit: 4,                    null: false
    t.integer  "desire_to_work_id",     limit: 4,                    null: false
    t.text     "notes",                 limit: 65535
    t.boolean  "is_invitation_enabled", limit: 1,     default: true, null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.string   "title",                 limit: 255,   null: false
    t.text     "desc",                  limit: 65535, null: false
    t.integer  "how_to_reply",          limit: 4,     null: false
    t.string   "company_name",          limit: 255,   null: false
    t.string   "company_email",         limit: 255,   null: false
    t.string   "company_phone_number",  limit: 255,   null: false
    t.string   "representative_person", limit: 255,   null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "desc",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "message_type",       limit: 4,                     null: false
    t.integer  "engineer_id",        limit: 4,                     null: false
    t.integer  "company_id",         limit: 4,                     null: false
    t.string   "title",              limit: 255,                   null: false
    t.text     "desc",               limit: 65535,                 null: false
    t.string   "attached_file_name", limit: 255
    t.binary   "attached_file",      limit: 65535
    t.boolean  "is_read",            limit: 1,     default: false, null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "messages", ["engineer_id"], name: "index_messages_on_engineer_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "notification_type", limit: 4,                 null: false
    t.integer  "user_type",         limit: 4,                 null: false
    t.integer  "user_id",           limit: 4,                 null: false
    t.boolean  "is_done",           limit: 1, default: false, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
