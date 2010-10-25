require 'spec_helper'

describe TechnicalComponent do
  it { should belong_to :user }

  it { should validate_presence_of :name }

  it { should validate_presence_of :capacity }
  it { should allow_value(10).for(:capacity) }
  it { should_not allow_value(0).for(:capacity) }
  it { should_not allow_value(-1).for(:capacity) }

  it { should validate_presence_of :mtbf }
  it { should validate_presence_of :mttr }
  it { should validate_presence_of :repair_cost }

  it { should validate_presence_of :workforce }
  it { should allow_value(100).for(:workforce) }
  it { should_not allow_value(-1).for(:workforce) }

  it { should validate_presence_of :area }
  it { should allow_value(100).for(:area) }
  it { should_not allow_value(0).for(:area) }

  it { should validate_presence_of :capital_cost_min }
  it { should allow_value(100).for(:capital_cost_min) }
  it { should_not allow_value(0).for(:capital_cost_min) }

  it { should validate_presence_of :capital_cost_max }
  it { should allow_value(100).for(:capital_cost_max) }
  it { should_not allow_value(0).for(:capital_cost_max) }

  it { should validate_presence_of :environmental_disruptiveness }

  it { should validate_presence_of :waste_disposal_cost_min }
  it { should allow_value(100).for(:waste_disposal_cost_min) }
  it { should_not allow_value(0).for(:waste_disposal_cost_min) }

  it { should validate_presence_of :waste_disposal_cost_max }
  it { should allow_value(100).for(:waste_disposal_cost_max) }
  it { should_not allow_value(0).for(:waste_disposal_cost_max) }

  it { should validate_presence_of :noise }
  it { should allow_value(100).for(:noise) }
  it { should_not allow_value(-1).for(:noise) }

  it { should validate_presence_of :lifetime }
  it { should allow_value(100).for(:noise) }
  it { should_not allow_value(-1).for(:noise) }
end
