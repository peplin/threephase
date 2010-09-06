class GeneratorType < ActiveRecord::Base
  acts_as_technical_component
  has_many :generators, :foreign_key => "buildable_id"
  belongs_to :fuel

  validates :safety_mtbf, :presence => true
  validates :safety_incident_severity, :presence => true, :percentage => true
  validates :ramping_speed, :presence => true
  validates :fuel_efficiency, :presence => true
  validates :air_emissions, :presence => true
  validates :water_emissions, :presence => true
  validates :maintenance_cost_min, :presence => true
  validates :maintenance_cost_max, :presence => true
  validates :tax_credit, :presence => true
end
