Factory.define :city do |z|
  z.name "A City"
  z.association :state
  z.customers 1000
end

Factory.define :invalid_city, :parent => :city do |z|
  z.x -1
end

Factory.define :auction_city, :parent => :city do |z|
  z.association :state, :factory => :auction_state
end

Factory.define :another_city, :parent => :city do |z|
  z.name "Another City"
end
