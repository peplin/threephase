Factory.define :line, :class => Line do |l|
  l.association :line_type
  l.association :zone
  l.association :other_zone, :factory => :zone
  l.buildable_type "LineType"
end

Factory.define :another_line, :parent => :line do |l|
end

Factory.define :invalid_line, :parent => :line do |l|
  l.zone_id nil
end
