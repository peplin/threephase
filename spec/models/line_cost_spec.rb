require 'spec_helper'

describe LineCost do
  it { should belong_to :line_type }
  it { should validate_presence_of :length_min }
  it { should validate_presence_of :length_max }
  it { should validate_presence_of :cost_min }
  it { should validate_presence_of :cost_max }
end

describe LineMaintenanceCost do
end

describe LineCapitolCost do
end
