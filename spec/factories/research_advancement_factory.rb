Factory.define :research_advancement do |f|
  f.reason "For the hell of it."
  f.parameter "technology_cost"
  f.adjustment -1 * rand(5)
  f.association :region
end
