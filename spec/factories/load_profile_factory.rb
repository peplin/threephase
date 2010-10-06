Factory.define :load_profile do |p|
  p.hour rand(23)
  p.association :city
end
