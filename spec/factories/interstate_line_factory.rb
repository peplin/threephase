Factory.define :interstate_line do |l|
  l.association :incoming_region, :factory => :region
  l.association :outgoing_region, :factory => :region
  l.association :line_type
end

Factory.define :another_interstate_line, :parent => :interstate_line do |l|
end

Factory.define :invalid_interstate_line, :parent => :interstate_line do |l|
  l.incoming_region_id nil
end
