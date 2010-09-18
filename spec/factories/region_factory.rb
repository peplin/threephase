Factory.define :region do |r|
  r.name "A Region"
  r.association :map, :factory => :map
  r.association :game, :factory => :game
  r.association :user, :factory => :user
end
