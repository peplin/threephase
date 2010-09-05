require 'spec_helper'

describe MarketPrice do
  it { should belong_to :game }
  it { should validate_presence_of :price }
end

describe FuelMarketPrice do 
  it { should belong_to :fuel }
end
