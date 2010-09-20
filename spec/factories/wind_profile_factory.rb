Factory.define :wind_profile do |p|
  p.hour rand(23)
  p.association :block
end
