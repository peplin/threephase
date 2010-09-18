Factory.sequence :zone_x do |n|
  n
end

Factory.sequence :zone_y do |n|
  n
end

Factory.define :zone do |z|
  z.name "A Zone"
  z.x { Factory.next :zone_x }
  z.y { Factory.next :zone_y }
  z.association :region, :factory => :region
end
