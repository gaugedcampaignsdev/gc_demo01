# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100710190413) do

  create_table "accounts", :force => true do |t|
    t.integer  "donor_id"
    t.string   "name",          :limit => 100
    t.string   "card_type",     :limit => 40
    t.string   "creditcard_no", :limit => 40
    t.string   "expiration",    :limit => 10
    t.string   "cvv_code",      :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaign_statuses", :force => true do |t|
    t.string   "name",       :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", :force => true do |t|
    t.integer  "admin_id"
    t.integer  "campaign_status_id"
    t.string   "title",              :limit => 100
    t.text     "description"
    t.float    "target_amount"
    t.string   "logo_file_name",     :limit => 200
    t.string   "logo_content_type",  :limit => 100
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "slogan",             :limit => 200
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",       :limit => 100
    t.string   "address",    :limit => 200
    t.string   "city",       :limit => 50
    t.string   "state",      :limit => 2
    t.string   "zip_code",   :limit => 5
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dialables", :force => true do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.string   "first_name",  :limit => 50
    t.string   "last_name",   :limit => 50
    t.string   "business",    :limit => 50
    t.string   "address",     :limit => 50
    t.string   "city",        :limit => 50
    t.string   "state",       :limit => 2
    t.string   "zip_code",    :limit => 5
    t.string   "phone",       :limit => 10
    t.string   "email",       :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "donation"
    t.text     "note"
    t.integer  "account_id"
  end

  create_table "donors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.string   "first_name",  :limit => 50
    t.string   "last_name",   :limit => 50
    t.string   "business",    :limit => 50
    t.string   "address",     :limit => 200
    t.string   "city",        :limit => 50
    t.string   "state",       :limit => 2
    t.string   "zip_code",    :limit => 5
    t.string   "phone",       :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",       :limit => 50
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "users", :force => true do |t|
    t.integer  "company_id"
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "first_name",                :limit => 50
    t.string   "last_name",                 :limit => 50
    t.string   "email",                     :limit => 50
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.boolean  "is_agent"
    t.boolean  "is_company_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
