require 'spec_helper'

describe Game do
  it { should have_many :fuel_market_prices }
  it { should have_many :spot_market_prices }
  it { should have_many :carbon_credit_market_prices }
  it { should have_many :regions }
  it { should have_many(:users).through(:regions) }
  it { should have_many(:maps).through(:regions) }
  it { should have_many(:generator_types).through(:allowed_generator_types) }

  it { should validate_presence_of :speed}
  it { should validate_presence_of :max_players}
  it { should validate_presence_of :max_line_capacity}
  it { should validate_presence_of :technology_cost}
  it { should validate_presence_of :technology_reliability}
  it { should validate_presence_of :power_factor}
  it { should validate_presence_of :frequency}
  it { should validate_presence_of :wind_speed}
  it { should validate_presence_of :sunfall}
  it { should validate_presence_of :water_flow }
  it { should validate_presence_of :regulation_type }
  it { should validate_presence_of :starting_capitol }
  it { should validate_presence_of :interest_rate }
  it { should validate_presence_of :reliability_constraint }
  it { should validate_presence_of :fuel_cost }
  it { should validate_presence_of :fuel_cost_volatility }
  it { should validate_presence_of :workforce_reliability }
  it { should validate_presence_of :workforce_cost }
  it { should validate_presence_of :unionized }
  it { should validate_presence_of :carbon_allowance }
  it { should validate_presence_of :tax_credit }
  it { should validate_presence_of :renewable_requirement }
  it { should validate_presence_of :political_stability }
  it { should validate_presence_of :political_opposition }
  it { should validate_presence_of :public_support }
end
