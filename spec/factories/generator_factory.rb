Factory.define :generator do |g|
  g.association :generator_type, :factory => :generator_type
  g.association :zone, :factory => :zone
end
