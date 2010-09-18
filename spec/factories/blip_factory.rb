Factory.sequence :blip_x do |n|
  n
end

Factory.sequence :blip_y do |n|
  n
end

Factory.define :blip do |b|
  b.x { Factory.next :blip_x }
  b.y { Factory.next :blip_y }
  b.power_factor rand(1)
  b.assocation :zone, :factory => :zone
end
