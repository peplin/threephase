Factory.define :storage_device_type, :class => StorageDeviceType,
    :parent => :technical_component do |t|
  t.decay_rate 1 + rand(60)
  t.efficiency rand(100)
end

Factory.define :another_storage_device_type, :parent => :storage_device_type do |t|
  t.decay_rate 100
end

Factory.define :invalid_storage_device_type, :parent => :storage_device_type do |t|
  t.efficiency -1
end
