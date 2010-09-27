Factory.define :line_type, :class => LineType,
    :parent => :technical_component do |t|
  t.voltage 720
  t.resistance 100
  t.diameter 1 + rand(4)
  t.height -10 + rand(20)
end

Factory.define :another_line_type, :parent => :line_type do |t|
  t.voltage 480
end

Factory.define :invalid_line_type, :parent => :line_type do |t|
  t.voltage -1
end
