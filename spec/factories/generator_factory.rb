Factory.define :generator, :class => Generator do |g|
  g.association :generator_type
  g.association :zone
  g.buildable_type "GeneratorType"
end
