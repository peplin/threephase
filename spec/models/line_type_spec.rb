require 'spec_helper'

describe LineType do
  it { should have_many :line_maintenance_costs }
  it { should have_many :line_capitol_costs }
  it { should validate_presence_of :ac }
  it { should validate_presence_of :voltage }
  it { should validate_presence_of :resistance }
  it { should validate_presence_of :diameter }
  it { should validate_presence_of :height }
end
