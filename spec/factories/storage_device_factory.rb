Factory.define :storage_device, :class => StorageDevice do |d|
  d.association :storage_device_type
  d.buildable_type "StorageDeviceType"
  d.association :zone
end

Factory.define :another_storage_device, :parent => :storage_device do |d|
end

Factory.define :invalid_storage_device, :parent => :storage_device do |d|
  d.zone_id nil
end
