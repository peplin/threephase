class Generator < TechnicalComponentInstance
  belongs_to :generator_type, :foreign_key => "buildable_id"
  has_many :bids
  has_many :accepted_bids, :conditions => "accepted = TRUE"

  validates :generator_type, :presence => true

  def takes_bids?
    state.game.regulation_type == :auction
  end

  def marginal_cost
    generator_type.marginal_cost(state.game, operating_level)
  end

  def marginal_fuel_cost
    generator_type.marginal_fuel_cost(state.game, operating_level)
  end

  def cost_since time
    fuel_cost_since(time) + (marginal_cost * operated_hours(time))
  end

  def fuel_cost_since time
    marginal_fuel_cost * fuel_used_since(time)
  end

  def fuel_used_since time
    generator_type.marginal_fuel(operating_level) * operated_hours(time)
  end

  def step time
    cost = cost_since(time)
    state.cash -= cost
    state.save
  end
end
