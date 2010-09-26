class GeneratorType < ActiveRecord::Base
  acts_as_technical_component
  has_many :generators, :foreign_key => "buildable_id"
  belongs_to :fuel_type

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

  def marginal_cost
  end

  def fuel_amount
  end

  def to_s
    "#{super} using #{fuel_type}"
  end
end
