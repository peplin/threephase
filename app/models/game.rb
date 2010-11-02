require 'simple'

class Game < ActiveRecord::Base
  include SimpleExtensions

  acts_as_limited
  has_many :market_prices
  has_many :fuel_markets, :through => :market_prices
  has_many :allowed_generator_types
  has_many :allowed_line_types
  has_many :generator_types, :through => :allowed_generator_types
  has_many :line_types, :through => :allowed_line_types
  has_many :states
  has_many :users, :through => :states
  has_many :maps, :through => :states

  enum_attr :regulation_type, [:lmp, :ror, :auction] do
    label :ror => "Rate of Return"
  end
  validates :regulation_type, :presence => true
  validates :rate_of_return, :presence => true, :percentage => true,
      :if => Proc.new { |game| game.regulation_type == :ror }

  validates :speed, :presence => true, :numericality => {
      :greater_than_or_equal_to => 1, :less_than_or_equal_to => 200}
  validates :max_players, :numericality => {:greater_than_or_equal_to => 1},
      :allow_nil => true

  validates :max_line_capacity, :presence => true, :numericality => {
      :greater_than_or_equal_to => 25, :less_than_or_equal_to => 2000}
  validates :technology_cost, :presence => true, :percentage => true
  validates :technology_reliability, :presence => true, :percentage => true
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

  after_create :initialize_markets
  before_validation :set_default_ror, :on => :create

  def current_price market
    market.current_price self
  end

  def state_for user
    states.find_by_user(user)
  end

  def in_progress?
    not ended
  end

  def step
  end

  def generators fuel_market=nil
    states.collect do |state|
      if fuel_market
        state.generators.find_by_fuel_market(fuel_market)
      else
        state.generators
      end
    end.flatten
  end

  def time_since_update
    time_since updated_at
  end

  def to_s
    "#{states.count} confirmed players, #{started ? "started #{started}" : "not started"}"
  end

  def time
    if not @time
      klass = Class.new(DelegateClass(Time)) do
        class << self
          attr_reader :speed, :epoch

          def at other
            if other.is_a?(self)
              new(other)
            else
              new(epoch + speed * (other - epoch))
            end
          end

          def now
            at(Time.now)
          end
        end

        def initialize time
          super(time)
        end

        def - other
          super(self.class.at(other))
        end
      end
      klass.instance_variable_set(:@speed, speed)
      klass.instance_variable_set(:@epoch, created_at)
      # TODO could get into trouble here, because this is a class constant
      # shared by intances of Game with different epoch/speeds.
      @time = Game.const_set("GameTime", klass)
    end
    @time
  end

  private

  def set_default_ror
    if not rate_of_return
      self.rate_of_return = 8
    end
  end

  def initialize_markets
    FuelMarket.all.each do |market|
      market.initialize_for(self)
    end
  end
end
