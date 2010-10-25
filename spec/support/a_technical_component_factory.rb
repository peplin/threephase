Factory.define :technical_component do |c|
  c.name "A Technical Component"
  c.capacity 250
  c.mtbf 15 + rand(100)
  c.mttr 30 + rand(100)
  c.repair_cost rand(100)
  c.workforce 20 + rand(75)
  c.area 1000 + rand(5000)
  c.capital_cost_max 1000000
  c.environmental_disruptiveness rand(100)
  c.waste_disposal_cost_max 10000
  c.noise rand(100)
  c.lifetime 10 + rand(50)
end
