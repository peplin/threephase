Factory.define :fuel_type do |f|
  f.name "Coal"
  f.description "A sedimentary rock."
  f.association :market
end

Factory.define :renewable_fuel_type, :parent => :fuel_type do |f|
  f.renewable true
end
