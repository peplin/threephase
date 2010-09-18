Factory.define :interstate_line do |l|
  l.association :incoming_region, :factory => :region
  l.association :outgoing_region, :factory => :region
  l.association :line_type, :factory => :line_type
end
