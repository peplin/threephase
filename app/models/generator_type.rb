class GeneratorType < ActiveRecord::Base
  acts_as_technical_component
  has_many :generators, :foreign_key => "buildable_id"
  belongs_to :fuel_type

  attr_accessible :safety_mtbf, :safety_incident_severity, :ramping_speed,
      :fuel_efficiency, :air_emissions, :water_emissions, :maintenance_cost_min,
      :maintenance_cost_max, :tax_credit

  validates :safety_mtbf, :presence => true
  validates :safety_incident_severity, :presence => true, :percentage => true
  validates :ramping_speed, :presence => true
  validates :fuel_efficiency, :presence => true, :percentage => true
  validates :air_emissions, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0}
  validates :water_emissions, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0}
  validates :maintenance_cost_min, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0}
  validates :maintenance_cost_max, :presence => true, :numericality => {
      :greater_than_or_equal_to => 1}
  validates :tax_credit, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0}
  validates :fuel_type, :presence => true

  def renewable?
    fuel_type.renewable
  end

  def marginal_cost game, operating_level=100
    marginal_fuel(operating_level) * game.current_price(fuel_type.market)
  end

  def marginal_fuel operating_level=100
    return 0 if renewable?
    operating_level * fuel_efficiency
  end

  def to_s
    "#{technical_component} using #{fuel_type}"
  end
end
