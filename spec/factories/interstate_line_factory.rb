Factory.define :interstate_line do |l|
  l.association :incoming_state, :factory => :state
  l.association :outgoing_state, :factory => :state
  l.association :line_type
end

Factory.define :invalid_interstate_line, :parent => :interstate_line do |l|
  l.incoming_state_id nil
end
