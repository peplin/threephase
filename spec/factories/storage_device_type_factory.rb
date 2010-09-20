Factory.define :storage_device_type do |t|
  t.decay_rate 1 + rand(60)
  t.efficiency rand(100)
end
