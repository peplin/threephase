require 'spec_helper'

describe MarketPrice do
  it { should belong_to :game }
  it { should belong_to :fuel_market }
  it { should validate_presence_of :game }
  it { should validate_presence_of :fuel_market }
  it { should validate_presence_of :price }
end
