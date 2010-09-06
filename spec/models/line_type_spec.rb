require 'spec_helper'

describe LineType do
  it { should have_one :technical_component }
  it { should have_many :lines }
  it { should have_many :interstate_lines }
  it { should have_many :line_maintenance_costs }
  it { should have_many :line_capitol_costs }

  it { should validate_presence_of :ac }

  it { should validate_presence_of :voltage }
  it { should allow_value(120).for(:voltage) }
  it { should_not allow_value(0).for(:voltage) }

  it { should validate_presence_of :resistance }
  it { should_not allow_value(-1).for(:resistance) }

  it { should validate_presence_of :diameter }
  it { should allow_value(10).for(:diameter) }
  it { should_not allow_value(26).for(:diameter) }
  it { should_not allow_value(0).for(:diameter) }

  it { should validate_presence_of :height }
  it { should allow_value(30).for(:height) }
  it { should allow_value(-10).for(:height) }
  it { should_not allow_value(101).for(:height) }
  it { should_not allow_value(-26).for(:height) }
end
