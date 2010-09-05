class GeneratorType < ActiveRecord::Base
  acts_as_technical_component
  has_many :generators
  belongs_to :fuel
  validates_presence_of :safety_mtbf
  validates_presence_of :safety_incident_severity
  validates_presence_of :ramping_speed
  validates_presence_of :fuel_efficiency
  validates_presence_of :air_emissions
  validates_presence_of :water_emissions
  validates_presence_of :maintenance_cost_min
  validates_presence_of :maintenance_cost_max
  validates_presence_of :tax_credit
end
