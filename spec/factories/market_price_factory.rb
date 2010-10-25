Factory.define :market_price do |m|
  m.price 1 + rand(100)
  m.association :fuel_market
  m.association :game
end
