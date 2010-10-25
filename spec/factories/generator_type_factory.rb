Factory.define :generator_type, :class => GeneratorType,
    :parent => :technical_component do |t|
  t.safety_mtbf 30 + rand(100)
  t.ramping_speed 1 + rand(60)
  t.marginal_fuel_burn_rate rand(100)
  t.air_emissions rand(100)
  t.water_emissions rand(100)
  t.maintenance_cost_max 1000 + rand(1000)
  t.tax_credit rand(1000)
  t.association :fuel_market
end

Factory.define :renewable_generator_type, :parent => :generator_type do |t|
  t.marginal_fuel_burn_rate 0
end

Factory.define :another_generator_type, :parent => :generator_type do |t|
  t.safety_mtbf 10
end

Factory.define :invalid_generator_type, :parent => :generator_type do |t|
  t.marginal_fuel_burn_rate -1
end
