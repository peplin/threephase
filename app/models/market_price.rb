class MarketPrice < ActiveRecord::Base
  self.inheritance_column = :market_type
  belongs_to :game
  validates_presence_of :price
end

class FuelMarketPrice < MarketPrice
  belongs_to :fuel
end

class CarbonCreditMarketPrice < MarketPrice
end

class SpotMarketPrice < MarketPrice
end
