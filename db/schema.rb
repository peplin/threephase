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
    t.integer "game_id"
    t.integer "buildable_id"
    t.string  "buildable_type"
  end

  add_index "allowed_technical_component_types", ["buildable_id"], :name => "index_allowed_technical_component_types_on_buildable_id"
  add_index "allowed_technical_component_types", ["game_id"], :name => "index_allowed_technical_component_types_on_game_id"

  create_table "bids", :force => true do |t|
    t.integer  "price"
    t.boolean  "accepted"
    t.integer  "generator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blips", :force => true do |t|
    t.integer "x"
    t.integer "y"
    t.integer "power_factor"
    t.integer "zone_id"
  end

  add_index "blips", ["x", "y", "zone_id"], :name => "index_blips_on_x_and_y_and_zone_id", :unique => true

  create_table "blocks", :force => true do |t|
    t.integer  "x"
    t.integer  "y"
    t.integer  "elevation"
    t.integer  "type"
    t.float    "wind_speed"
    t.integer  "water_flow"
    t.integer  "sunfall"
    t.integer  "natural_gas_index"
    t.integer  "coal_index"
    t.integer  "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocks", ["x", "y", "map_id"], :name => "index_blocks_on_x_and_y_and_map_id", :unique => true

  create_table "contract_negotiations", :force => true do |t|
    t.string   "reason"
    t.integer  "amount"
    t.boolean  "offline"
    t.integer  "generator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contract_offers", :force => true do |t|
    t.integer  "proposed_amount"
    t.boolean  "accepted"
    t.integer  "contract_negotiation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fuel_contracts", :force => true do |t|
    t.integer  "approved"
    t.float    "price_per_unit"
    t.integer  "amount"
    t.integer  "duration"
    t.integer  "fuel_id"
    t.integer  "proposing_region_id"
    t.integer  "receiving_region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fuels", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "games", :force => true do |t|
    t.integer  "max_line_capacity"
    t.integer  "technology_cost"
    t.integer  "technology_reliability"
    t.integer  "power_factor"
    t.integer  "frequency"
    t.integer  "wind_speed"
    t.integer  "sunfall"
    t.integer  "water_flow"
    t.integer  "regulation_type"
    t.float    "starting_capitol"
    t.integer  "interest_rate"
    t.integer  "reliability_constraint"
    t.integer  "fuel_cost"
    t.integer  "fuel_cost_volatility"
    t.integer  "workforce_reliability"
    t.integer  "workforce_cost"
    t.boolean  "unionized"
    t.integer  "carbon_allowance"
    t.integer  "tax_credit"
    t.integer  "renewable_requirement"
    t.integer  "political_stability"
    t.integer  "political_opposition"
    t.integer  "public_support"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generator_types", :force => true do |t|
    t.integer  "safety_mtbf"
    t.integer  "safety_incident_severity"
    t.integer  "ramping_speed"
    t.float    "fuel_efficiency"
    t.integer  "air_emissions"
    t.integer  "water_emissions"
    t.integer  "maintenance_cost_min"
    t.integer  "maintenance_cost_max"
    t.float    "tax_credit"
    t.integer  "fuel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interstate_lines", :force => true do |t|
    t.boolean  "accepted"
    t.integer  "region_id"
    t.integer  "line_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_costs", :id => false, :force => true do |t|
    t.string  "cost_type"
    t.integer "length_min"
    t.integer "length_max"
    t.integer "cost_min"
    t.integer "cost_max"
    t.integer "technical_component_id"
  end

  create_table "line_types", :force => true do |t|
    t.boolean  "ac"
    t.integer  "voltage"
    t.integer  "resistance"
    t.float    "diameter"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "load_profiles", :force => true do |t|
    t.integer "hour"
    t.integer "demand"
    t.integer "zone_id"
  end

  create_table "maps", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "market_prices", :force => true do |t|
    t.string   "market_type"
    t.float    "price"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string  "name"
    t.integer "research_budget"
    t.integer "map_id"
    t.integer "game_id"
    t.integer "user_id"
  end

  create_table "repairs", :force => true do |t|
    t.string   "reason"
    t.integer  "cost"
    t.boolean  "offline"
    t.integer  "repairable_id"
    t.string   "repairable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "research_advancements", :force => true do |t|
    t.string   "reason"
    t.string   "parameter"
    t.float    "adjustment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storage_device_types", :force => true do |t|
    t.float    "decay_rate"
    t.integer  "efficiency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technical_component_instances", :force => true do |t|
    t.string   "instance_type"
    t.integer  "zone_id"
    t.integer  "buildable_type_id"
    t.string   "buildable_type_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technical_components", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "peak_capacity_min"
    t.integer  "peak_capacity_max"
    t.integer  "average_capacity"
    t.integer  "mtbf"
    t.integer  "mttr"
    t.integer  "repair_cost"
    t.integer  "workforce"
    t.integer  "area"
    t.integer  "capitol_cost_min"
    t.integer  "capitol_cost_max"
    t.integer  "environmental_disruptiveness"
    t.integer  "waste_disposal_cost_min"
    t.integer  "waste_disposal_cost_max"
    t.integer  "noise"
    t.boolean  "online"
    t.integer  "lifetime"
    t.integer  "user_id"
    t.integer  "buildable_id"
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
    t.integer "hour"
    t.float   "speed"
    t.integer "block_id"
  end

  create_table "zones", :force => true do |t|
    t.string  "name"
    t.integer "x"
    t.integer "y"
    t.integer "region_id"
  end

  add_index "zones", ["x", "y"], :name => "index_zones_on_x_and_y", :unique => true

end
