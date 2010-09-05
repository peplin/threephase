require 'spec_helper'

describe MarketPrice do
  it { should belong_to :game }
  it { should validate_presence_of :price }
  it { should validate_presence_of :market_type }
end
