require 'spec_helper'

describe FuelContract do
  it { should belong_to :fuel }
  it { should belong_to :proposing_region }
  it { should belong_to :receiving_region }
  it { should_not validate_presence_of :approved }
  it { should validate_presence_of :price_per_unit }
  it { should validate_presence_of :amount }
  it { should validate_presence_of :duration }
end
