require 'spec_helper'

describe PeakDemand do
  it { should belong_to :city }
  it { should validate_presence_of :peak_demand }
  it { should validate_presence_of :city }
end
