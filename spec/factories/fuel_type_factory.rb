Factory.define :fuel_type do |f|
  f.name "Coal"
  f.description "A sedimentary rock."
  f.association :market
end
