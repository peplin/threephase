require 'spec_helper'

describe FuelType do
  it { should belong_to :market }
  it { should have_many(:market_prices).through(:market) }
  it { should have_many :generator_types }
  it { should validate_presence_of :name }
end
