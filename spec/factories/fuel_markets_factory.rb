Factory.define :fuel_market do |f|
  f.name "Coal"
  f.description "A sedimentary rock."
  f.initial_average_price 42
  f.initial_standard_deviation 4
  f.related_natural_resource "coal"
end
