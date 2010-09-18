Factory.define :bid do |b|
  b.price 1 + rand(10)
  b.association :generator, :factory => :geneator
end
