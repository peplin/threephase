require 'spec_helper'

describe GeneratorType do
  it { should belong_to :fuel }
  it { should validate_presence_of :safety_mtbf }
  it { should validate_presence_of :safety_incident_severity }
  it { should validate_presence_of :ramping_speed }
  it { should validate_presence_of :fuel_efficiency }
  it { should validate_presence_of :air_emissions }
  it { should validate_presence_of :water_emissions }
  it { should validate_presence_of :maintenance_cost_min }
  it { should validate_presence_of :maintenance_cost_max }
  it { should validate_presence_of :tax_credit }
end
