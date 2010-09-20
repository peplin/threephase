Factory.define :generator_type, :parent => :technical_component do |t|
  t.safety_mtbf 30 + rand(100)
  t.ramping_speed 1 + rand(60)
  t.fuel_efficiency rand(100)
  t.air_emissions rand(100)
  t.water_emissions rand(100)
  t.maintenance_cost_max 1000 + rand(1000)
  t.tax_credit rand(1000)
  t.association :fuel_type
  t.association :buildable_type, :factory => :generator_type
end
