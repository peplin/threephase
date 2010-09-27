Factory.define :generator, :class => Generator do |g|
  g.association :generator_type
  g.association :zone
  g.buildable_type "GeneratorType"
end

Factory.define :another_generator, :parent => :generator do |g|
end

Factory.define :invalid_generator, :parent => :generator do |g|
  g.zone_id nil
end
