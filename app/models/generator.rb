require 'query_extensions'

class Generator < TechnicalComponentInstance
  belongs_to :generator_type, :foreign_key => "buildable_id"
  has_many :bids, :extend => FindByDayExtension
  has_many :accepted_bids, :conditions => "accepted = TRUE"
  has_one :fuel_market, :through => :generator_type

  validates :generator_type, :presence => true

  def takes_bids?
    state.game.regulation_type == :auction
  end

  def bid time=nil
    if bid = bids.find_by_day(game, time)
      bid.price
    else
      marginal_cost time
    end
  end

  def bid= price
    bids.create :price => price
  end

  def marginal_cost time=nil
    generator_type.marginal_cost(city, time)
  end

  def average_cost time=nil
    capital_cost / capacity + marginal_cost(time)
  end

  def marginal_fuel_cost time=nil
    generator_type.marginal_fuel_cost(city, time)
  end

  def cost_since time
    fuel_cost_since(time)
  end

  def fuel_cost_since time
    game.time.now.range(time).step(10.minutes).inject(0) do |total, t|
      total + operating_fuel_cost(game.time.at(t)) / 6.0
    end
  end

  def fuel_used_since time
    game.time.now.range(time).step(10.minutes).inject(0) do |total, t|
      total + fuel_burn_rate(game.time.at(t)) / 6.0
    end
  end

  def fuel_burn_rate time=nil
    operating_fuel(operating_level(time))
  end

  def average_fuel_burn_rate time=nil
    operating_fuel(average_operating_level(time))
  end

  def operating_fuel level
    generator_type.marginal_fuel_burn_rate * level
  end

  def operating_cost time=nil
    operating_fuel_cost(time)
  end

  def operating_fuel_cost time=nil
    marginal_fuel_cost(time) * operating_level(time)
  end
end
