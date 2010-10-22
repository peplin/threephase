class Generator < TechnicalComponentInstance
  belongs_to :generator_type, :foreign_key => "buildable_id"
  has_many :bids
  has_many :accepted_bids, :conditions => "accepted = TRUE"

  validates :generator_type, :presence => true

  def takes_bids?
    city.state.game.regulation_type == :auction
  end

  def fuel_since time
    operated_hours = Float(Time.now - time) / 1.hour
    generator_type.marginal_fuel(operating_level) * operated_hours
  end
end
