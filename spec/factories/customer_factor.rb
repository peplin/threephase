Factory.sequence :customer_x do |n|
  n
end

Factory.sequence :customer_y do |n|
  n
end

Factory.define :customer do |b|
  b.x { Factory.next :customer_x }
  b.y { Factory.next :customer_y }
  b.power_factor rand(1)
  b.association :city
end
