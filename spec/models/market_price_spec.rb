require 'spec_helper'

describe MarketPrice do
  it { should belong_to :game }
  it { should belong_to :market }
  it { should validate_presence_of :game }
  it { should validate_presence_of :market }
  it { should validate_presence_of :price }
end
