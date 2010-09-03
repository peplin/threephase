class MarketPrice < ActiveRecord::Base
  belongs_to :game
end

class SpotMarketPrice < MarketPrice
end

class NaturalGasMarketPrice < MarketPrice
end

class CarbonCreditMarketPrice < MarketPrice
end

class NuclearFuelMarketPrice < MarketPrice
end

class GasMarketPrice < MarketPrice
end

class CoalMarketPrice < MarketPrice
end
