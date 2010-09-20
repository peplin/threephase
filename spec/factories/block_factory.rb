Factory.sequence :block_x do |n|
  n
end

Factory.sequence :block_y do |n|
  n
end

Factory.define :block do |b|
  b.x { Factory.next :block_x }
  b.y { Factory.next :block_y }
  b.association :map, :factory => :map
end

Factory.define :mountain_block, :parent => :block do |b|
  b.type :mountain
  b.elevation 100 + rand(600)
end

Factory.define :water_block, :parent => :block do |b|
  b.type :water
  b.water_flow rand(20)
end

Factory.define :sunny_block, :parent => :block do |b|
  b.type :plains
  b.sunfall 3000 + rand(4000)
end

Factory.define :windy_block, :parent => :block do |b|
  b.type :plains
  b.wind_speed rand(30)
end
