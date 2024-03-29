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

ActiveRecord::Schema.define(version: 20160510074005) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "feedbacks", force: :cascade do |t|
    t.string   "hashed_id"
    t.text     "content"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "feedbacks", ["project_id"], name: "index_feedbacks_on_project_id"
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id"

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "project_id"
  end

  add_index "images", ["project_id"], name: "index_images_on_project_id"

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
  end

  add_index "members", ["project_id"], name: "index_members_on_project_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "hashed_id"
    t.string   "name"
    t.string   "headline"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "score"
  end

  add_index "projects", ["hashed_id"], name: "index_projects_on_hashed_id"
  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "feedback_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "replies", ["feedback_id"], name: "index_replies_on_feedback_id"
  add_index "replies", ["user_id"], name: "index_replies_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "hashed_id"
    t.integer  "appreciation"
    t.integer  "member_id"
    t.integer  "unread"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["hashed_id"], name: "index_users_on_hashed_id"
  add_index "users", ["member_id"], name: "index_users_on_member_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

  create_table "workplaces", force: :cascade do |t|
    t.string   "company"
    t.string   "position"
    t.string   "emoji",      limit: 1
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "workplaces", ["user_id"], name: "index_workplaces_on_user_id"

end
