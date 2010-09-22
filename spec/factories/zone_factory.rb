Factory.sequence :zone_x do |n|
  rand(1000000)
end

Factory.sequence :zone_y do |n|
  rand(1000000)
end

Factory.define :zone do |z|
  z.name "A Zone"
  z.x { Factory.next :zone_x }
  z.y { Factory.next :zone_y }
  z.association :region
end

Factory.define :invalid_zone, :parent => :zone do |z|
  z.x -1
end
