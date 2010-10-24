class FuelType < ActiveRecord::Base
  belongs_to :market
  has_many :generator_types
  has_many :generators, :through => :generator_types do
    def find_by_game game
      # Raw SQL to get around the fact that rails doesn't create the double
      # join here properly. 
      find(:all, :joins => "INNER JOIN cities ON technical_component_instances.city_id = cities.id INNER JOIN states ON cities.state_id = states.id",
          :conditions => {:states => {:game_id => game}})
    end
  end
  has_many :market_prices, :through => :market
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true

  def average_demand game, time=nil
    generators.find_by_game(game).inject(0) {|demand, generator|
      demand + generator.average_fuel_burn_rate(time)
    }
  end

  def demand game
    generators.find_by_game(game).inject(0) {|demand, generator|
      demand + generator.fuel_burn_rate
    }
  end

  def to_s
    name
  end
end
