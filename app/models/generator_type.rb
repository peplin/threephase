class GeneratorType < ActiveRecord::Base
  acts_as_technical_component
  has_many :generators, :foreign_key => "buildable_id"
  belongs_to :fuel_type

  attr_accessible *TechnicalComponent.attr_accessible
  attr_accessible :safety_mtbf, :safety_incident_severity, :ramping_speed,
      :marginal_fuel_burn_rate, :air_emissions, :water_emissions, :maintenance_cost_min,
      :maintenance_cost_max, :tax_credit, :fuel_type_id

  validates :safety_mtbf, :presence => true
  validates :safety_incident_severity, :presence => true, :percentage => true
  validates :ramping_speed, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}
  validates :marginal_fuel_burn_rate, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}
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
    marginal_fuel_burn_rate == 0
  end

  def operating_cost city, operating_level=100
    operating_fuel_cost(city, operating_level)
  end

  def operating_fuel_cost city, operating_level=100
    marginal_fuel_cost(city) * operating_capacity(operating_level)
  end

  def operating_capacity operating_level=100
    operating_level * capacity
  end

  def marginal_cost city
    marginal_fuel_cost(city)
  end

  def marginal_fuel_cost city
    marginal_fuel_burn_rate * city.current_price(fuel_type.market)
  end

  def to_s
    "#{technical_component} using #{fuel_type}"
  end
end
