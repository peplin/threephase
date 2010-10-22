Factory.define :generator, :class => Generator do |g|
  g.association :generator_type
  g.association :city
  g.buildable_type "GeneratorType"
end

Factory.define :another_generator, :parent => :generator do |g|
end

Factory.define :invalid_generator, :parent => :generator do |g|
  g.city_id nil
end

Factory.define :auction_generator, :parent => :generator do |g|
  g.association :city, :factory => :auction_city
end
