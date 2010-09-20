Factory.define :storage_device, :class => StorageDevice do |l|
  l.association :storage_device_type
  l.buildable_type "StorageDeviceType"
  l.association :zone
end
