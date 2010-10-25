class GeneratorType < ActiveRecord::Base
  acts_as_technical_component
  has_many :generators, :foreign_key => "buildable_id"
  belongs_to :fuel_type

  attr_accessible *TechnicalComponent.attr_accessible
  attr_accessible :safety_mtbf, :safety_incident_severity, :ramping_speed,
      :fuel_efficiency, :air_emissions, :water_emissions, :maintenance_cost_min,
      :maintenance_cost_max, :tax_credit, :fuel_type_id

  validates :safety_mtbf, :presence => true
  validates :safety_incident_severity, :presence => true, :percentage => true
  validates :ramping_speed, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}
  validates :fuel_efficiency, :presence => true,
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
    fuel_efficiency == 0
  end

  def marginal_cost city, operating_level=100
    marginal_fuel_cost(city, operating_level)
  end

  def marginal_fuel_cost city, operating_level=100
    marginal_fuel(operating_level) * city.current_price(fuel_type.market)
  end

  def marginal_fuel operating_level=100
    operating_level * fuel_efficiency
  end

  def to_s
    "#{technical_component} using #{fuel_type}"
  end
end
