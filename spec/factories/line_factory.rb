Factory.define :line, :class => Line do |l|
  l.association :line_type
  l.association :zone
  l.association :ending_zone, :factory => :zone
  l.buildable_type "LineType"
end
