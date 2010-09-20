class Game < ActiveRecord::Base
  has_many :market_prices
  has_many :markets, :through => :market_prices
  has_many :allowed_generator_types
  has_many :allowed_line_types
  has_many :allowed_storage_device_types
  has_many :generator_types, :through => :allowed_generator_types
  has_many :line_types, :through => :allowed_line_types
  has_many :storage_device_types, :through => :allowed_storage_device_types
  has_many :regions
  has_many :users, :through => :regions
  has_many :maps, :through => :regions

  validates :max_line_capacity, :presence => true
  validates :technology_cost, :presence => true, :percentage => true
  validates :technology_reliability, :presence => true, :percentage => true
  validates :power_factor, :presence => true, :percentage => true
  validates :frequency, :presence => true
  validates :wind_speed, :presence => true, :percentage => true
  validates :sunfall, :presence => true, :percentage => true
  validates :water_flow, :presence => true, :percentage => true

  validates :regulation_type, :presence => true
  validates :starting_capital, :presence => true
  validates :interest_rate, :presence => true, :percentage => true
  validates :reliability_constraint, :presence => true
  validates :fuel_cost, :presence => true, :percentage => true
  validates :fuel_cost_volatility, :presence => true, :percentage => true
  validates :workforce_reliability, :presence => true, :percentage => true
  validates :workforce_cost, :presence => true, :percentage => true
  validates :unionized, :presence => true

  validates :carbon_allowance, :presence => true, :percentage => true
  validates :tax_credit, :presence => true, :percentage => true
  validates :renewable_requirement, :presence => true, :percentage => true
  validates :political_stability, :presence => true, :percentage => true
  validates :political_opposition, :presence => true, :percentage => true
  validates :public_support, :presence => true, :percentage => true
end
