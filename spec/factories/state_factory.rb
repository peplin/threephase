Factory.define :state do |r|
  r.name "A State"
  r.association :map
  r.association :game
  r.association :user
end

Factory.define :another_state, :parent => :state do |r|
  r.name "Another State"
end

Factory.define :invalid_state, :parent => :state do |r|
  r.name nil
end

Factory.define :auction_state, :parent => :state do |r|
  r.association :game, :factory => :auction_game
end
