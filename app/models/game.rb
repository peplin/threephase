require 'simple'

class Game < ActiveRecord::Base
  include SimpleExtensions

  TIME_SCALE_FACTOR = [1 / 0.8, 1 / 0.2]

  acts_as_limited
  has_many :market_prices
  has_many :markets, :through => :market_prices
  has_many :allowed_generator_types
  has_many :allowed_line_types
  has_many :allowed_storage_device_types
  has_many :generator_types, :through => :allowed_generator_types
  has_many :line_types, :through => :allowed_line_types
  has_many :storage_device_types, :through => :allowed_storage_device_types
  has_many :states
  has_many :users, :through => :states
  has_many :maps, :through => :states

  enum_attr :regulation_type, [:unregulated, :ror, :auction] do
    label :ror => "Rate of Return"
  end
  validates :regulation_type, :presence => true

  validates :speed, :presence => true, :percentage => true
  validates :max_players, :numericality => {:greater_than_or_equal_to => 1},
      :allow_nil => true

  validates :max_line_capacity, :presence => true, :numericality => {
      :greater_than_or_equal_to => 25, :less_than_or_equal_to => 2000}
  validates :technology_cost, :presence => true, :percentage => true
  validates :technology_reliability, :presence => true, :percentage => true
  validates :power_factor, :presence => true, :percentage => true
  validates :frequency, :presence => true, :numericality => {
      :greater_than_or_equal_to => 10, :less_than_or_equal_to => 120}
  validates :wind_speed, :presence => true, :percentage => true
  validates :sunfall, :presence => true, :percentage => true
  validates :water_flow, :presence => true, :percentage => true

  validates :starting_capital, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0, :less_than_or_equal_to => 500000000000}
  validates :interest_rate, :presence => true, :percentage => true
  validates :reliability_constraint, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}
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

  def current_price market
    market.current_price @game
  end

  def in_progress?
    not ended
  end

  def time_since_update
    time_since updated_at
  end

  def to_s
    "#{states.count} confirmed players, #{started ? "started #{started}" : "not started"}"
  end

  private

  def time_since time
    range_map(speed, 0, 100, TIME_SCALE_FACTOR[0],
        TIME_SCALE_FACTOR[1]) * (Time.now - time)
  end
end
