Factory.define :storage_device, :class => StorageDevice do |d|
  d.association :storage_device_type
  d.buildable_type "StorageDeviceType"
  d.association :city
end

Factory.define :invalid_storage_device, :parent => :storage_device do |d|
  d.city_id nil
end
