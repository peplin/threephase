class FuelMarket < ActiveRecord::Base
  has_many :market_prices do
    def find_current(game)
      price = find(:all, :conditions => {:game_id => game},
          :order => "created_at DESC", :limit => 1)
      if price
        price.first
      else
        nil
      end
    end
  end
  has_many :games, :through => :market_prices
  has_many :generator_types
  has_many :generators, :through => :generator_types do
    def find_by_game game
      # Raw SQL to get around the fact that rails doesn't create the double
      # join here properly. 
      find(:all, :joins => "INNER JOIN cities ON technical_component_instances.city_id = cities.id INNER JOIN states ON cities.state_id = states.id",
          :conditions => {:states => {:game_id => game}})
    end
  end
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true
  validates :initial_average_price, :presence => true,
      :numericality => {:greater_than => 0}
  validates :initial_standard_deviation, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}

  def average_demand game, time=nil
    generators.find_by_game(game).inject(0) {|demand, generator|
      if time and generator.created_at >= time
        demand
      else
        demand + generator.average_fuel_burn_rate(time)
      end
    }
  end

  def demand game
    generators.find_by_game(game).inject(0) {|demand, generator|
      demand + generator.fuel_burn_rate
    }
  end

  def clear game
    last_price = market_prices.find_current(game)
    old_demand = average_demand(game, last_price.created_at)
    new_demand = average_demand(game)
    new_price = last_price.price + (supply_slope * (new_demand - old_demand))
    market_prices.create :price => new_price, :game => game
  end

  def current_price game
    market_price = market_prices.find_current(game)
    if market_price
      market_price.price
    else
      0.0
    end
  end

  def current_local_price city
    current_price city.state.game
  end

  def average_price
    sum = games.inject(0) {|sum, game| sum + game.current_price(self) }
    sum / games.length
  end

  def initialize_for game
    positive = rand >= 0.5
    deviation = rand * initial_standard_deviation
    deviation *= -1 if not positive
    market_prices.create :game => game,
        :price => (initial_average_price + deviation)
  end

  def to_s
    name
  end
end
