Factory.define :region do |r|
  r.name "A Region"
  r.association :map
  r.association :game
  r.association :user
end
