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

ActiveRecord::Schema.define(version: 20141201160822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deq_process_type_arguments", force: true do |t|
    t.integer  "deq_process_type_id"
    t.string   "deq_argument"
    t.string   "json_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deq_process_types", force: true do |t|
    t.string   "processTypeId",             null: false
    t.integer  "message_sub_type_id",       null: false
    t.string   "originating_transactionId"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deq_response_id"
  end

  add_index "deq_process_types", ["processTypeId"], name: "Process Type Id", unique: true, using: :btree
  add_index "deq_process_types", ["processTypeId"], name: "process_type_id", using: :btree

  create_table "deq_responses", force: true do |t|
    t.text     "response_string"
    t.datetime "resolved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "response_string_as_json"
  end

  create_table "global_variables", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_flows", force: true do |t|
    t.integer  "message_id"
    t.integer  "flow_order"
    t.integer  "user_id"
    t.datetime "date_received"
    t.datetime "date_resolved"
    t.integer  "response_choice_id"
    t.string   "response_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deq_response_id"
  end

  create_table "message_links", force: true do |t|
    t.integer  "message_id"
    t.string   "display_title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_sub_types", force: true do |t|
    t.integer  "message_type_id"
    t.string   "sub_type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "processTypeId"
    t.integer  "deq_response_id"
  end

  create_table "message_types", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "message_sub_type_id"
    t.string   "subject"
    t.string   "body"
    t.integer  "user_id"
    t.datetime "resolved_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dollar_amt"
    t.string   "q_transaction_id"
    t.string   "q_source_id"
    t.string   "q_cost_center_id"
    t.string   "q_process_type_id"
    t.integer  "deq_response_id"
  end

  add_index "messages", ["q_transaction_id"], name: "transaction_id", using: :btree

  create_table "response_choices", force: true do |t|
    t.integer  "message_sub_type_id"
    t.integer  "display_order"
    t.string   "button_title"
    t.string   "button_style"
    t.string   "api_string"
    t.boolean  "note_required"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "api_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ees_employee_code"
    t.integer  "deq_response_id"
  end

  add_index "users", ["ees_employee_code"], name: "ees_emp_code", unique: true, using: :btree

end
