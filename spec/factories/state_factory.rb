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
