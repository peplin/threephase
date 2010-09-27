Factory.define :offer do |o|
  o.proposed_amount 1 + rand(100)
  o.association :contract
end

Factory.define :another_offer, :parent => :offer do |o|
  o.proposed_amount 101 + rand(100)
end

Factory.define :invalid_offer, :parent => :offer do |o|
  o.proposed_amount -1
end
