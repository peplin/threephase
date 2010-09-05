require 'spec_helper'

describe LineType do
  it { should have_one :technical_component }
  it { should have_many :lines }
  it { should have_many :interstate_lines }
  it { should have_many :line_maintenance_costs }
  it { should have_many :line_capitol_costs }
  it { should validate_presence_of :ac }
  it { should validate_presence_of :voltage }
  it { should validate_presence_of :resistance }
  it { should validate_presence_of :diameter }
  it { should validate_presence_of :height }
end
