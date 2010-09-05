class Game < ActiveRecord::Base
  has_many :spot_market_prices
  has_many :fuel_market_prices
  has_many :carbon_credit_market_prices
  has_many :generator_types, :through => :allowed_technical_component_types
  has_many :line_types, :through => :allowed_technical_component_types
  has_many :storage_device_types, :through => :allowed_technical_component_types
  has_many :regions
  has_many :users, :through => :region
  has_many :maps, :through => :region
  validates_presence_of :max_line_capacity
  validates_presence_of :technology_cost
  validates_presence_of :technology_reliability
  validates_presence_of :power_factor
  validates_presence_of :frequency
  validates_presence_of :wind_speed
  validates_presence_of :sunfall
  validates_presence_of :water_flow
  validates_presence_of :regulation_type
  validates_presence_of :starting_capitol
  validates_presence_of :interest_rate
  validates_presence_of :reliability_constraint
  validates_presence_of :fuel_cost
  validates_presence_of :fuel_cost_volatility
  validates_presence_of :workforce_reliability
  validates_presence_of :workforce_cost
  validates_presence_of :unionized
  validates_presence_of :carbon_allowance
  validates_presence_of :tax_credit
  validates_presence_of :renewable_requirement
  validates_presence_of :political_stability
  validates_presence_of :political_opposition
  validates_presence_of :public_support
end
