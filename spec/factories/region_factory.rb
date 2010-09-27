Factory.define :region do |r|
  r.name "A Region"
  r.association :map
  r.association :game
  r.association :user
end

Factory.define :another_region, :parent => :region do |r|
  r.name "Another Region"
end

Factory.define :invalid_region, :parent => :region do |r|
  r.name nil
end
