Factory.define :offer do |o|
  o.proposed_amount 1 + rand(100)
  o.association :contract
end
