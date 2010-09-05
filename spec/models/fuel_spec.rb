require 'spec_helper'

describe Fuel do
  it { should have_many :fuel_contracts }
  it { should have_many :market_prices }
  it { should validate_presence_of :name }
end
