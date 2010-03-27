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

ActiveRecord::Schema.define(:version => 20100327166021) do

  create_table "event_participants", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "event_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_participants", ["user_id"], :name => "user_id"
  add_index "event_participants", ["event_id"], :name => "event_id"

  create_table "events", :force => true do |t|
    t.string   "name",            :limit => 60
    t.text     "description"
    t.string   "info_link",       :limit => 80
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "max_participant"
    t.datetime "created_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "image_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["parent_id"], :name => "index_images_on_parent_id"

  create_table "inquiries", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.integer  "position"
    t.boolean  "open",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inquiry_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "magazine_items", :force => true do |t|
    t.integer "magazine_number_id"
    t.integer "copy_number"
  end

  add_index "magazine_items", ["magazine_number_id"], :name => "magazine_number_id"

  create_table "magazine_numbers", :force => true do |t|
    t.string   "name"
    t.integer  "num_of_copy"
    t.integer  "magazine_subscription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "magazine_numbers", ["magazine_subscription_id"], :name => "magazine_subscription_id"

  create_table "magazine_subscriptions", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "news_items", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "publish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_items", ["id"], :name => "index_news_items_on_id"

  create_table "options", :force => true do |t|
    t.string "name"
    t.string "value"
  end

  create_table "page_parts", :force => true do |t|
    t.integer  "page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_parts", ["id"], :name => "index_page_parts_on_id"
  add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.integer  "position"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.string   "custom_title"
    t.string   "custom_title_type",   :default => "none"
    t.boolean  "draft",               :default => false
    t.string   "browser_title"
    t.boolean  "skip_to_first_child", :default => false
  end

  add_index "pages", ["id"], :name => "index_pages_on_id"
  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"

  create_table "refinery_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_settings", ["name"], :name => "index_refinery_settings_on_name"

  create_table "rental_histories", :force => true do |t|
    t.integer "magazine_item_id"
    t.integer "user_id"
    t.date    "rent_on"
    t.date    "return_on"
  end

  add_index "rental_histories", ["magazine_item_id"], :name => "magazine_item_id"
  add_index "rental_histories", ["user_id"], :name => "user_id"

  create_table "rental_queues", :force => true do |t|
    t.integer  "magazine_number_id"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "rental_queues", ["magazine_number_id"], :name => "magazine_number_id"
  add_index "rental_queues", ["user_id"], :name => "user_id"

  create_table "rental_subscriptions", :force => true do |t|
    t.integer "magazine_subscription_id"
    t.integer "user_id"
  end

  add_index "rental_subscriptions", ["magazine_subscription_id"], :name => "magazine_subscription_id"
  add_index "rental_subscriptions", ["user_id"], :name => "user_id"

  create_table "rentals", :force => true do |t|
    t.integer "magazine_item_id"
    t.integer "user_id"
    t.date    "rent_on"
    t.date    "last_remind_date"
  end

  add_index "rentals", ["magazine_item_id"], :name => "magazine_item_id"
  add_index "rentals", ["user_id"], :name => "user_id"

  create_table "resources", :force => true do |t|
    t.string   "content_type"
    t.string   "filename"
    t.integer  "size"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_positions", :id => false, :force => true do |t|
    t.integer "user_id", :null => false
    t.integer "role_id", :null => false
  end

  add_index "role_positions", ["user_id"], :name => "user_id"
  add_index "role_positions", ["role_id"], :name => "role_id"

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_name_and_sluggable_type_and_scope_and_sequence", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "sponsors", :force => true do |t|
    t.string "name"
    t.string "homepage"
    t.string "image_url"
  end

  create_table "user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
    t.integer "position"
  end

  add_index "user_plugins", ["user_id", "title"], :name => "index_unique_user_plugins", :unique => true
  add_index "user_plugins", ["title"], :name => "index_user_plugins_on_title"

  create_table "users", :force => true do |t|
    t.string   "login",                                :null => false
    t.string   "email",                                :null => false
    t.string   "crypted_password",                     :null => false
    t.string   "password_salt",                        :null => false
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "superuser",         :default => false
    t.string   "perishable_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "mobile_phone"
    t.string   "location"
    t.boolean  "paid",              :default => false
    t.text     "comment"
    t.string   "member_since"
    t.string   "golf_id"
    t.string   "golf_hcp"
    t.string   "golf_club"
    t.string   "type"
  end

  add_index "users", ["id"], :name => "index_users_on_id"

  add_foreign_key "event_participants", ["user_id"], "users", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "event_participants_ibfk_1"
  add_foreign_key "event_participants", ["event_id"], "events", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "event_participants_ibfk_2"

  add_foreign_key "magazine_items", ["magazine_number_id"], "magazine_numbers", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "magazine_items_ibfk_1"

  add_foreign_key "magazine_numbers", ["magazine_subscription_id"], "magazine_subscriptions", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "magazine_numbers_ibfk_1"

  add_foreign_key "rental_histories", ["magazine_item_id"], "magazine_items", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "rental_histories_ibfk_1"
  add_foreign_key "rental_histories", ["user_id"], "users", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "rental_histories_ibfk_2"

  add_foreign_key "rental_queues", ["magazine_number_id"], "magazine_numbers", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "rental_queues_ibfk_1"
  add_foreign_key "rental_queues", ["user_id"], "users", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "rental_queues_ibfk_2"

  add_foreign_key "rental_subscriptions", ["magazine_subscription_id"], "magazine_subscriptions", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "rental_subscriptions_ibfk_1"
  add_foreign_key "rental_subscriptions", ["user_id"], "users", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "rental_subscriptions_ibfk_2"

  add_foreign_key "rentals", ["magazine_item_id"], "magazine_items", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "rentals_ibfk_1"
  add_foreign_key "rentals", ["user_id"], "users", ["id"], :on_update => :cascade, :name => "rentals_ibfk_2"

  add_foreign_key "role_positions", ["user_id"], "users", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "role_positions_ibfk_1"
  add_foreign_key "role_positions", ["role_id"], "roles", ["id"], :on_update => :cascade, :on_delete => :cascade, :name => "role_positions_ibfk_2"

end
