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

ActiveRecord::Schema.define(:version => 20101024180804) do

  create_table "access_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "key"
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["key"], :name => "index_access_tokens_on_key", :unique => true

  create_table "allowed_technical_component_types", :id => false, :force => true do |t|
    t.string  "component_type", :null => false
    t.integer "game_id",        :null => false
    t.integer "buildable_id",   :null => false
    t.string  "buildable_type", :null => false
  end

  add_index "allowed_technical_component_types", ["buildable_id"], :name => "index_allowed_technical_component_types_on_buildable_id"
  add_index "allowed_technical_component_types", ["game_id"], :name => "index_allowed_technical_component_types_on_game_id"

  create_table "average_operating_levels", :force => true do |t|
    t.integer  "technical_component_instance_id", :null => false
    t.integer  "operating_level",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bids", :force => true do |t|
    t.integer  "price",        :null => false
    t.boolean  "accepted"
    t.integer  "generator_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blocks", :force => true do |t|
    t.integer  "x",                                   :null => false
    t.integer  "y",                                   :null => false
    t.integer  "elevation",         :default => 0,    :null => false
    t.string   "block_type",                          :null => false
    t.float    "wind_index",        :default => 0.0,  :null => false
    t.integer  "water_index",       :default => 0,    :null => false
    t.integer  "sun_index",         :default => 5125, :null => false
    t.integer  "natural_gas_index", :default => 0,    :null => false
    t.integer  "coal_index",        :default => 0,    :null => false
    t.integer  "oil_index",         :default => 0,    :null => false
    t.integer  "map_id",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocks", ["x", "y", "map_id"], :name => "index_blocks_on_x_and_y_and_map_id", :unique => true

  create_table "cities", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "x",           :null => false
    t.integer  "y",           :null => false
    t.integer  "customers"
    t.datetime "stepped_at"
    t.string   "cached_slug"
    t.integer  "state_id",    :null => false
  end

  add_index "cities", ["cached_slug"], :name => "index_cities_on_cached_slug", :unique => true
  add_index "cities", ["x", "y", "state_id"], :name => "index_cities_on_x_and_y_and_state_id"

  create_table "fuel_markets", :force => true do |t|
    t.string "name",                                        :null => false
    t.text   "description"
    t.string "cached_slug"
    t.float  "initial_average_price",                       :null => false
    t.float  "initial_standard_deviation",                  :null => false
    t.float  "supply_slope",               :default => 1.0, :null => false
  end

  add_index "fuel_markets", ["cached_slug"], :name => "index_fuel_markets_on_cached_slug", :unique => true

  create_table "games", :force => true do |t|
    t.integer  "speed",                  :default => 0,             :null => false
    t.datetime "updated_at"
    t.integer  "max_players"
    t.datetime "started"
    t.datetime "ended"
    t.integer  "max_line_capacity",      :default => 1500,          :null => false
    t.integer  "technology_cost",        :default => 50,            :null => false
    t.integer  "technology_reliability", :default => 50,            :null => false
    t.integer  "frequency",              :default => 60,            :null => false
    t.integer  "wind_speed",             :default => 50,            :null => false
    t.integer  "sunfall",                :default => 50,            :null => false
    t.integer  "water_flow",             :default => 50,            :null => false
    t.string   "regulation_type",        :default => "unregulated", :null => false
    t.float    "starting_capital",       :default => 500000000.0,   :null => false
    t.integer  "interest_rate",          :default => 6,             :null => false
    t.integer  "reliability_constraint", :default => 1,             :null => false
    t.integer  "fuel_cost",              :default => 50,            :null => false
    t.integer  "fuel_cost_volatility",   :default => 50,            :null => false
    t.integer  "workforce_reliability",  :default => 50,            :null => false
    t.integer  "workforce_cost",         :default => 50,            :null => false
    t.boolean  "unionized",              :default => true,          :null => false
    t.integer  "carbon_allowance",       :default => 50,            :null => false
    t.integer  "tax_credit",             :default => 50,            :null => false
    t.integer  "renewable_requirement",  :default => 50,            :null => false
    t.integer  "political_stability",    :default => 50,            :null => false
    t.integer  "political_opposition",   :default => 50,            :null => false
    t.integer  "public_support",         :default => 50,            :null => false
    t.datetime "created_at"
  end

  create_table "generator_types", :force => true do |t|
    t.integer  "safety_mtbf",                              :null => false
    t.integer  "safety_incident_severity", :default => 50, :null => false
    t.integer  "ramping_speed",                            :null => false
    t.float    "marginal_fuel_burn_rate",                  :null => false
    t.integer  "air_emissions",                            :null => false
    t.integer  "water_emissions",                          :null => false
    t.integer  "maintenance_cost_min",     :default => 0,  :null => false
    t.integer  "maintenance_cost_max",                     :null => false
    t.float    "tax_credit",                               :null => false
    t.integer  "fuel_market_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interstate_lines", :force => true do |t|
    t.boolean  "accepted"
    t.integer  "operating_level",   :default => 100, :null => false
    t.integer  "incoming_state_id",                  :null => false
    t.integer  "outgoing_state_id",                  :null => false
    t.integer  "line_type_id",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_costs", :id => false, :force => true do |t|
    t.string  "cost_type",    :null => false
    t.integer "length_min",   :null => false
    t.integer "length_max",   :null => false
    t.integer "cost_min",     :null => false
    t.integer "cost_max",     :null => false
    t.integer "line_type_id", :null => false
  end

  create_table "line_types", :force => true do |t|
    t.boolean  "ac",         :default => true, :null => false
    t.integer  "voltage",                      :null => false
    t.integer  "resistance",                   :null => false
    t.float    "diameter",                     :null => false
    t.integer  "height",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "load_profiles", :force => true do |t|
    t.integer "hour",                   :null => false
    t.integer "demand",  :default => 0, :null => false
    t.integer "city_id",                :null => false
  end

  create_table "maps", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "cached_slug"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maps", ["cached_slug"], :name => "index_maps_on_cached_slug", :unique => true

  create_table "market_prices", :force => true do |t|
    t.float    "price",          :null => false
    t.integer  "fuel_market_id", :null => false
    t.integer  "game_id",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repairs", :force => true do |t|
    t.string   "reason",                             :null => false
    t.integer  "cost",                               :null => false
    t.boolean  "offline",         :default => false, :null => false
    t.integer  "duration",                           :null => false
    t.integer  "repairable_id",                      :null => false
    t.string   "repairable_type",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "research_advancements", :force => true do |t|
    t.string   "reason",     :null => false
    t.string   "parameter",  :null => false
    t.float    "adjustment", :null => false
    t.integer  "state_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "states", :force => true do |t|
    t.string   "name",                                 :null => false
    t.integer  "research_budget", :default => 5000000, :null => false
    t.integer  "cash"
    t.datetime "stepped_at"
    t.integer  "map_id",                               :null => false
    t.integer  "game_id",                              :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storage_device_types", :force => true do |t|
    t.float    "decay_rate",                 :null => false
    t.integer  "efficiency", :default => 50, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technical_component_instances", :force => true do |t|
    t.string   "instance_type",                    :null => false
    t.integer  "operating_level", :default => 100, :null => false
    t.datetime "stepped_at"
    t.integer  "city_id",                          :null => false
    t.integer  "other_city_id"
    t.integer  "buildable_id",                     :null => false
    t.string   "buildable_type",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technical_components", :force => true do |t|
    t.string   "name",                                        :null => false
    t.text     "description"
    t.integer  "capacity",                                    :null => false
    t.integer  "mtbf",                                        :null => false
    t.integer  "mttr",                                        :null => false
    t.integer  "repair_cost",                                 :null => false
    t.integer  "workforce",                                   :null => false
    t.integer  "area",                                        :null => false
    t.integer  "capital_cost_min",             :default => 1, :null => false
    t.integer  "capital_cost_max",                            :null => false
    t.integer  "environmental_disruptiveness",                :null => false
    t.integer  "waste_disposal_cost_min",      :default => 1, :null => false
    t.integer  "waste_disposal_cost_max",                     :null => false
    t.integer  "noise",                                       :null => false
    t.integer  "lifetime",                                    :null => false
    t.integer  "user_id"
    t.integer  "buildable_id",                                :null => false
    t.string   "buildable_type",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                    :null => false
    t.integer  "login_count",       :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.integer  "active_token_id"
    t.boolean  "admin",             :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["active_token_id"], :name => "index_users_on_active_token_id"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

  create_table "wind_profiles", :force => true do |t|
    t.integer "hour",                      :null => false
    t.float   "speed",    :default => 0.0, :null => false
    t.integer "block_id",                  :null => false
  end

end
