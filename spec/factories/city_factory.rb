Factory.define :city do |z|
  z.name "A City"
  z.association :state
  z.after_create { |city| attach_customers city }
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

def attach_customers city
  3.times do 
    Factory :customer, :city => city
  end
end
