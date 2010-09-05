require 'spec_helper'

describe Fuel do
  it { should have_many :fuel_contracts }
  it { should have_many :fuel_market_prices }
  it { should have_many :generator_types }
  it { should validate_presence_of :name }
end
