Factory.define :line_type, :parent => :technical_component do |t|
  t.voltage 720
  t.resistance 100
  t.diameter 1 + rand(4)
  t.height -10 + rand(20)
end
