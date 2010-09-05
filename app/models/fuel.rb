class Fuel < ActiveRecord::Base
  has_many :generator_types
  has_many :fuel_contracts
  has_many :fuel_market_prices
  validates_presence_of :name
end
