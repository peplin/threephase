Factory.define :state do |r|
  r.name "A State"
  r.association :map
  r.association :game
  r.association :user
  r.costs_deducted_at 1.hour.ago
  r.customers_charged_at 1.hour.ago
  r.stepped_at 1.hour.ago
  r.created_at 2.hours.ago # since game time depends on epoch being in the past
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
