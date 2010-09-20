Factory.define :contract_negotiation do |c|
  c.reason "For the hell of it."
  c.amount 1 + rand(100)
  c.association :generator
end
