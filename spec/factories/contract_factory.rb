Factory.define :contract do |c|
  c.reason "For the hell of it."
  c.amount 1 + rand(100)
  c.association :generator
end

Factory.define :another_contract, :parent => :contract do |c|
  c.amount 101 + rand(50)
end

Factory.define :invalid_contract, :parent => :contract do |c|
  c.amount -1
end
