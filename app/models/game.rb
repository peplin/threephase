class Game < ActiveRecord::Base
  has_many :spot_market_prices
  has_many :natural_gas_market_prices
  has_many :carbon_credit_market_prices
  has_many :nuclear_fuel_market_prices
  has_many :gas_market_prices
  has_many :coal_market_prices
end
