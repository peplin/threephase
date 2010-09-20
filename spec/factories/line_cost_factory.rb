Factory.define :line_maintenance_cost do |c|
  c.length_min 0
  c.length_max 1000
  c.cost_min 10000
  c.cost_max 60000
  c.association :line_type
end

Factory.define :line_capital_cost, :parent => :line_maintenance_cost do |c|
end
