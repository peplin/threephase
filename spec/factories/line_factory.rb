Factory.define :line, :class => Line do |l|
  l.association :line_type
  l.association :city
  l.association :other_city, :factory => :city
  l.buildable_type "LineType"
end

Factory.define :invalid_line, :parent => :line do |l|
  l.city_id nil
end
