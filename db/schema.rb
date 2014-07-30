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

ActiveRecord::Schema.define(:version => 20140730211621) do

  create_table "message_flows", :force => true do |t|
    t.integer  "message_id"
    t.integer  "flow_order"
    t.integer  "user_id"
    t.datetime "date_received"
    t.datetime "date_resolved"
    t.integer  "response_choice_id"
    t.string   "response_notes"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "message_links", :force => true do |t|
    t.integer  "message_id"
    t.string   "display_title"
    t.string   "url"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "message_sub_types", :force => true do |t|
    t.integer  "type_id"
    t.string   "subtype_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "message_types", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "type_id"
    t.integer  "subtype_id"
    t.string   "subject"
    t.string   "body"
    t.integer  "originator_user_id"
    t.datetime "resolved_date"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "response_choices", :force => true do |t|
    t.integer  "subtype_id"
    t.integer  "display_order"
    t.string   "button_title"
    t.string   "button_style"
    t.string   "api_string"
    t.boolean  "note_required"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "api_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
