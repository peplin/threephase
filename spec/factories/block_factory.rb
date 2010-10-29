Factory.sequence :block_x do |n|
  n
end

Factory.sequence :block_y do |n|
  n
end

Factory.define :block do |b|
  b.x { Factory.next :block_x }
  b.y { Factory.next :block_y }
  b.block_type :mountain
  b.association :map
end

Factory.define :mountain_block, :parent => :block do |b|
  b.block_type :mountain
  b.elevation 100 + rand(600)
end

Factory.define :water_block, :parent => :block do |b|
  b.block_type :water
  b.water_index rand(20)
end

Factory.define :sunny_block, :parent => :block do |b|
  b.block_type :plains
  b.sun_index 3000 + rand(4000)
end

Factory.define :windy_block, :parent => :block do |b|
  b.block_type :plains
  b.wind_index rand(30)
end
