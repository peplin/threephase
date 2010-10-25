class Generator < TechnicalComponentInstance
  belongs_to :generator_type, :foreign_key => "buildable_id"
  has_many :bids
  has_many :accepted_bids, :conditions => "accepted = TRUE"
  has_one :fuel_market, :through => :generator_type

  validates :generator_type, :presence => true

  def takes_bids?
    state.game.regulation_type == :auction
  end

  def marginal_cost
    generator_type.marginal_cost(city, operating_level)
  end

  def marginal_fuel_cost
    generator_type.marginal_fuel_cost(city, operating_level)
  end

  def cost_since time
    fuel_cost_since(time) + (marginal_cost * operated_hours(time))
  end

  def fuel_cost_since time
    marginal_fuel_cost * fuel_used_since(time)
  end

  def fuel_used_since time, level=nil
    level = operating_level if not level
    generator_type.marginal_fuel(level) * operated_hours(time)
  end

  def fuel_burn_rate level=nil
    fuel_used_since(1.hour.ago, level)
  end

  def average_fuel_burn_rate time=nil
    fuel_burn_rate(average_operating_level(time))
  end

  def average_operating_level time=nil
    time = Time.now if not time
    level = average_operating_levels.find(:all, :conditions => {
        :created_at => time.at_beginning_of_day..time.end_of_day}
        ).first
    if not level
      level = average_operating_levels.create(
          :operating_level => operating_level, :created_at => time)
    end
    level.operating_level
  end

  def step time
    cost = cost_since(time)
    state.cash -= cost
    state.save
  end
end
