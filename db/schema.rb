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

ActiveRecord::Schema.define(:version => 20100905173026) do

  create_table "allowed_technical_component_types", :id => false, :force => true do |t|
    t.integer "game_id",        :null => false
    t.integer "buildable_id",   :null => false
    t.string  "buildable_type", :null => false
  end

  add_index "allowed_technical_component_types", ["buildable_id"], :name => "index_allowed_technical_component_types_on_buildable_id"
  add_index "allowed_technical_component_types", ["game_id"], :name => "index_allowed_technical_component_types_on_game_id"

  create_table "bids", :force => true do |t|
    t.integer  "price",        :null => false
    t.boolean  "accepted"
    t.integer  "generator_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blips", :force => true do |t|
    t.integer "x",            :null => false
    t.integer "y",            :null => false
    t.integer "power_factor", :null => false
    t.integer "zone_id",      :null => false
  end

  add_index "blips", ["x", "y", "zone_id"], :name => "index_blips_on_x_and_y_and_zone_id", :unique => true

  create_table "blocks", :force => true do |t|
    t.integer  "x",                 :null => false
    t.integer  "y",                 :null => false
    t.integer  "elevation",         :null => false
    t.integer  "type",              :null => false
    t.float    "wind_speed",        :null => false
    t.integer  "water_flow",        :null => false
    t.integer  "sunfall",           :null => false
    t.integer  "natural_gas_index", :null => false
    t.integer  "coal_index",        :null => false
    t.integer  "map_id",            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocks", ["x", "y", "map_id"], :name => "index_blocks_on_x_and_y_and_map_id", :unique => true

  create_table "contract_negotiations", :force => true do |t|
    t.string   "reason",       :null => false
    t.integer  "amount",       :null => false
    t.boolean  "offline",      :null => false
    t.integer  "generator_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contract_offers", :force => true do |t|
    t.integer  "proposed_amount",         :null => false
    t.boolean  "accepted"
    t.integer  "contract_negotiation_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fuel_contracts", :force => true do |t|
    t.datetime "approved"
    t.float    "price_per_unit",      :null => false
    t.integer  "amount",              :null => false
    t.integer  "duration",            :null => false
    t.integer  "fuel_id",             :null => false
    t.integer  "proposing_region_id", :null => false
    t.integer  "receiving_region_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fuels", :force => true do |t|
    t.string "name",        :null => false
    t.text   "description"
  end

  create_table "games", :force => true do |t|
    t.integer  "max_line_capacity",      :null => false
    t.integer  "technology_cost",        :null => false
    t.integer  "technology_reliability", :null => false
    t.integer  "power_factor",           :null => false
    t.integer  "frequency",              :null => false
    t.integer  "wind_speed",             :null => false
    t.integer  "sunfall",                :null => false
    t.integer  "water_flow",             :null => false
    t.integer  "regulation_type",        :null => false
    t.float    "starting_capitol",       :null => false
    t.integer  "interest_rate",          :null => false
    t.integer  "reliability_constraint", :null => false
    t.integer  "fuel_cost",              :null => false
    t.integer  "fuel_cost_volatility",   :null => false
    t.integer  "workforce_reliability",  :null => false
    t.integer  "workforce_cost",         :null => false
    t.boolean  "unionized",              :null => false
    t.integer  "carbon_allowance",       :null => false
    t.integer  "tax_credit",             :null => false
    t.integer  "renewable_requirement",  :null => false
    t.integer  "political_stability",    :null => false
    t.integer  "political_opposition",   :null => false
    t.integer  "public_support",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generator_types", :force => true do |t|
    t.datetime "safety_mtbf",              :null => false
    t.integer  "safety_incident_severity", :null => false
    t.datetime "ramping_speed",            :null => false
    t.float    "fuel_efficiency",          :null => false
    t.integer  "air_emissions",            :null => false
    t.integer  "water_emissions",          :null => false
    t.integer  "maintenance_cost_min",     :null => false
    t.integer  "maintenance_cost_max",     :null => false
    t.float    "tax_credit",               :null => false
    t.integer  "fuel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interstate_lines", :force => true do |t|
    t.boolean  "accepted"
    t.integer  "region_id",    :null => false
    t.integer  "line_type_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_costs", :id => false, :force => true do |t|
    t.string  "cost_type",              :null => false
    t.integer "length_min",             :null => false
    t.integer "length_max",             :null => false
    t.integer "cost_min",               :null => false
    t.integer "cost_max",               :null => false
    t.integer "technical_component_id", :null => false
  end

  create_table "line_types", :force => true do |t|
    t.boolean  "ac",         :null => false
    t.integer  "voltage",    :null => false
    t.integer  "resistance", :null => false
    t.float    "diameter",   :null => false
    t.integer  "height",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "load_profiles", :force => true do |t|
    t.integer "hour",    :null => false
    t.integer "demand",  :null => false
    t.integer "zone_id", :null => false
  end

  create_table "maps", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "market_prices", :force => true do |t|
    t.string   "market_type", :null => false
    t.float    "price",       :null => false
    t.integer  "game_id",     :null => false
    t.integer  "fuel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string  "name",            :null => false
    t.integer "research_budget", :null => false
    t.integer "map_id",          :null => false
    t.integer "game_id",         :null => false
    t.integer "user_id"
  end

  create_table "repairs", :force => true do |t|
    t.string   "reason",          :null => false
    t.integer  "cost",            :null => false
    t.boolean  "offline",         :null => false
    t.integer  "repairable_id",   :null => false
    t.string   "repairable_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "research_advancements", :force => true do |t|
    t.string   "reason",     :null => false
    t.string   "parameter",  :null => false
    t.float    "adjustment", :null => false
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storage_device_types", :force => true do |t|
    t.float    "decay_rate", :null => false
    t.integer  "efficiency", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technical_component_instances", :force => true do |t|
    t.string   "instance_type",       :null => false
    t.integer  "zone_id",             :null => false
    t.integer  "buildable_type_id",   :null => false
    t.string   "buildable_type_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technical_components", :force => true do |t|
    t.string   "name",                         :null => false
    t.text     "description"
    t.integer  "peak_capacity_min",            :null => false
    t.integer  "peak_capacity_max",            :null => false
    t.integer  "average_capacity",             :null => false
    t.datetime "mtbf",                         :null => false
    t.datetime "mttr",                         :null => false
    t.integer  "repair_cost",                  :null => false
    t.integer  "workforce",                    :null => false
    t.integer  "area",                         :null => false
    t.integer  "capitol_cost_min",             :null => false
    t.integer  "capitol_cost_max",             :null => false
    t.integer  "environmental_disruptiveness", :null => false
    t.integer  "waste_disposal_cost_min",      :null => false
    t.integer  "waste_disposal_cost_max",      :null => false
    t.integer  "noise",                        :null => false
    t.boolean  "operating",                    :null => false
    t.datetime "lifetime",                     :null => false
    t.integer  "user_id"
    t.integer  "buildable_id",                 :null => false
    t.string   "buildable_type",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                     :limit => 100
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.boolean  "admin"
    t.string   "encrypted_password",        :limit => 128
    t.string   "confirmation_token",        :limit => 128
    t.boolean  "email_confirmed",                          :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wind_profiles", :force => true do |t|
    t.integer "hour",     :null => false
    t.float   "speed",    :null => false
    t.integer "block_id", :null => false
  end

  create_table "zones", :force => true do |t|
    t.string  "name",      :null => false
    t.integer "x",         :null => false
    t.integer "y",         :null => false
    t.integer "region_id", :null => false
  end

  add_index "zones", ["x", "y"], :name => "index_zones_on_x_and_y", :unique => true

end
