Factory.define :zone do |z|
  z.name "A Zone"
  z.association :state
end

Factory.define :invalid_zone, :parent => :zone do |z|
  z.x -1
end

Factory.define :another_zone, :parent => :zone do |z|
  z.name "Another Zone"
end
