require 'query_extensions'

class State < ActiveRecord::Base
  # Don't place cities any closer than this
  CITY_BUFFER = 50

  has_many :research_advancements
  has_many :marginal_prices,
      :extend => [FindByDayExtension, FindLatestExtension]
  has_many :outgoing_interstate_lines, :class_name => "InterstateLine",
      :foreign_key => "outgoing_state_id"
  has_many :incoming_interstate_lines, :class_name => "InterstateLine",
      :foreign_key => "incoming_state_id"
  has_many :cities, :extend => FindNearestCityExtension
  has_many :generators, :through => :cities do
    def find_by_fuel_market fuel_market
      # Raw SQL to get around the fact that rails doesn't create the double
      # join here properly. 
      find(:all, :joins => "INNER JOIN generator_types ON technical_component_instances.buildable_id = generator_types.id",
          :conditions => {:generator_types => {:fuel_market_id => fuel_market}})
    end

    def ordered_by_marginal_cost time=nil
      time ||= Time.now.utc
      find_existing_at(time).sort {|a, b|
        a.marginal_cost(time) <=> b.marginal_cost(time)
      }
    end

    def find_existing_at time
      time ||= Time.now.utc
      find(:all, :readonly => false, :conditions => ["created_at <= ?", time])
    end
  end
  belongs_to :map
  belongs_to :game
  belongs_to :user

  validates :name, :presence => true
  validates :research_budget, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}
  validates :cash, :numericality => {:greater_than_or_equal_to => 0},
      :allow_nil => true
  validates :map, :presence => true
  validates :game, :presence => true
  validates :user, :presence => true

  before_create :generate_starting_cash
  after_create :generate_starting_cities

  def natural_resource_index index
    map.natural_resource_index index
  end

  def interstate_lines
    InterstateLine.with_state(id)
  end

  def repairs
    cities.collect(&:repairs).flatten
  end

  def bids
    cities.collect(&:bids).flatten
  end

  def lines
    cities.collect(&:lines).flatten
  end

  def capacity time=nil
    generators.find_existing_at(time).inject(0) {|total, generator|
      total + generator.capacity
    }
  end

  def demand time=nil
    cities.inject(0) {|sum, city|
      sum + city.demand(time)
    }
  end

  def peak_demand time=nil
    cities.inject(0) {|sum, city|
      sum + city.peak_demand(time)
    }
  end

  def next_free_coordinates
    begin
      x = rand(map.width)
      y = rand(map.height)
    end while (cities.count > 0 and
        cities.find_nearest(x, y).distance(x, y) < CITY_BUFFER)
    [x, y]
  end

  def optimal_operating_level generator, time=nil
    operating_level = 0
    generators.ordered_by_marginal_cost(time).inject(0) do |level, gen|
      capacity_shortfall = demand(time) - level
      met_capacity = [gen.capacity, capacity_shortfall].min
      level += met_capacity

      if gen == generator
        operating_level = met_capacity
        break
      end
      break if capacity_shortfall <= 0
      level
    end
    operating_level
  end

  def marginal_price time=nil
    if price = marginal_prices.find_by_day(time)
      mc = price.marginal_price
    else
      mc = 0
      generators.ordered_by_marginal_cost.inject(0) do |level, gen|
        capacity_shortfall = peak_demand - level
        met_capacity = [gen.capacity, capacity_shortfall].min
        level += met_capacity
        if capacity_shortfall - level <= 0 or not demand_met?(time)
          mc = gen.marginal_cost
          break
        end
        level
      end
      marginal_prices.create :marginal_price => mc, :created_at => time
    end
    mc
  end

  def cost_since time
    cities.inject(0) do |cost, city|
      cost + city.cost_since(time)
    end
  end

  def deduct_operating_costs
    self.cash -= cost_since(costs_deducted_at)
    self.costs_deducted_at = Time.now
    self.cash
  end

  def charge_customers
    self.cash += (marginal_price * demanded_since(customers_charged_at))
    self.customers_charged_at = Time.now
    self.cash
  end

  def demand_met? time=nil
    capacity >= demand(time)
  end

  def demanded_since time
    cities.inject(0) do |demanded, city|
      city.demanded_since(time)
    end
  end

  def to_s
    name
  end

  private

  def generate_starting_cash
    self.cash = game.starting_capital
  end

  def generate_starting_cities
    (1 + rand(4)).times do
      self.cities << City.new
    end
  end
end
