Factory.define :bid do |b|
  b.price 1 + rand(10)
  b.association :generator
end

Factory.define :another_bid, :parent => :bid do |b|
  b.price 11 + rand(5)
end

Factory.define :invalid_bid, :parent => :bid do |b|
  b.price -1
end
