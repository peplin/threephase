Factory.define :line_cost do |c|
  c.cost_type LineCosc.CAPITOL_COST
  c.length_min 0
  c.length_max 1000
  c.cost_min 10000
  c.cost_min 60000
  c.association :line_type, :factory => :line_type
end
