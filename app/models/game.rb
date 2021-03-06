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
  validates :nickname, :presence => true
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

  def step_async
    states.each do |state|
      state.step_async
    end
  end

  def step
    states.each do |state|
      state.step
    end
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
    "#{nickname} (#{states.count} players)"
  end

  def time
    if not @time
      klass = Class.new(DelegateClass(Time)) do
        class << self
          attr_reader :speed, :epoch

          # TODO the repurcussions of this scale thing are HUGE. FIX IT.
          # will we ever want to scale if passing in a Fixnum, or will that be
          # from a range loop?
          def at other, scale=true
            if other.is_a?(self)
              new(other)
            else
              if not other.is_a?(Time)
                other = Time.at(other)
              end

              if scale
                new(scale(other))
              else
                new(other)
              end
            end
          end

          def now
            at(Time.now)
          end
          
          def to_normal time
            if time.is_a?(self)
              normal_time = Time.at(descale(time))
            else
              normal_time = time
            end
            normal_time
          end

          private

          def scale other
            check other
            epoch + speed * (other - epoch)
          end

          def descale other
            check other
            epoch + (other - epoch).to_i / speed
          end

          def check other
            if other < epoch
              raise RangeError, 'Time to scale must be after epoch'
            end
          end
        end

        def to_normal
          self.class.to_normal(self)
        end

        def range other, step=10.minutes
          delta = self.to_i - self.class.at(other).to_i
          if delta > 1.day
            step = 1.day
          end
          ((self.class.at(other).to_i + step)..self.to_i).step(step)
        end

        def - other
          # Need to avoid use of super here because of this bug in Ruby 1.9.2:
          # https://gist.github.com/455547
          #
          # This isn't a singleton method, but I think the Delegation parent is
          # mucking with it.
          # TODO it's problematic that these return Time, not GameTime -
          # we lose the metadata that this is a scaled time.
          # To get around it for now we have to unscale and rescale
          # Ugh, this is getting ugly - converting to integers loses precision.
          if other.is_a?(Fixnum) or other.is_a?(Float)
            self.class.at(Time.at(self) - other, false)
          elsif other.is_a?(self.class)
            Time.at(self) - other
          else
            Time.at(self) - self.class.at(other)
          end
        end
      end
      klass.instance_variable_set(:@speed, speed)
      klass.instance_variable_set(:@epoch, created_at)
      @time = klass
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
