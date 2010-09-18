Factory.define :market_price do |m|
  m.price 1 + rand(100)
  m.association :market, :factory => :market
  m.association :game, :factory => :game
end
