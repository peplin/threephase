Factory.define :city do |z|
  z.name "A City"
  z.association :state
end

Factory.define :invalid_city, :parent => :city do |z|
  z.x -1
end

Factory.define :another_city, :parent => :city do |z|
  z.name "Another City"
end
