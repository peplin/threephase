Factory.define :repair do |r|
  r.reason "For the hell of it."
  r.cost 1000 + rand(2000)
  r.duration 1 + rand(14)
  r.assocation :repairable_type, :factory => :generator
end
