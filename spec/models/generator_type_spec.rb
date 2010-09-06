require 'spec_helper'

describe GeneratorType do
  it { should have_one :technical_component }
  it { should have_many :generators }
  it { should belong_to :fuel }

  it { should validate_presence_of :safety_mtbf }
  it { should validate_presence_of :safety_incident_severity }
  it { should validate_presence_of :ramping_speed }

  it { should validate_presence_of :fuel_efficiency }
  it { should allow_value(101).for(:fuel_efficiency) }
  it { should_not allow_value(-1).for(:fuel_efficiency) }

  it { should validate_presence_of :air_emissions }
  it { should_not allow_value(-1).for(:air_emissions) }

  it { should validate_presence_of :water_emissions }
  it { should_not allow_value(-1).for(:water_emissions) }

  it { should validate_presence_of :maintenance_cost_min }
  it { should_not allow_value(-1).for(:maintenance_cost_min) }

  it { should validate_presence_of :maintenance_cost_max }
  it { should_not allow_value(0).for(:maintenance_cost_max) }

  it { should validate_presence_of :tax_credit }
  it { should_not allow_value(-1).for(:tax_credit) }
end
