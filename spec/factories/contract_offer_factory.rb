Factory.define :contract_offer do |o|
  o.proposed_amount 1 + rand(100)
  o.association :contract_negotiation, :factory => :contract_negotiation
end
