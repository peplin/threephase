Factory.define :average_operating_level do |a|
  a.association :technical_component_instance, :factory => :generator
  a.operating_level 42
end
