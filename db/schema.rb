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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130330064133) do

  create_table "authentications", :force => true do |t|
    t.integer  "auction_admin_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "error_traces", :force => true do |t|
    t.integer  "error_id"
    t.text     "application"
    t.text     "full"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "source_code"
    t.text     "url"
    t.text     "params"
    t.text     "action"
    t.text     "environment"
    t.text     "context"
    t.text     "cookies"
    t.text     "remote_ip"
    t.text     "browser"
  end

  add_index "error_traces", ["error_id"], :name => "index_error_traces_on_error_id"

  create_table "errors", :force => true do |t|
    t.integer  "project_id"
    t.integer  "status"
    t.integer  "count"
    t.text     "title"
    t.text     "desc"
    t.text     "url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "generated_at"
  end

  add_index "errors", ["project_id"], :name => "index_errors_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "pivotal_token"
    t.integer  "pivotal_project_id"
    t.string   "pivotal_project_name"
    t.string   "campfire_room"
    t.string   "campfire_subdomain"
    t.string   "campfire_token"
    t.boolean  "campfire_activate"
    t.integer  "campfire_room_id"
  end

  create_table "user_projects", :force => true do |t|
    t.integer  "role"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "status"
  end

  add_index "user_projects", ["project_id"], :name => "index_user_projects_on_project_id"
  add_index "user_projects", ["user_id"], :name => "index_user_projects_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
