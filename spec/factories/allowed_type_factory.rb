Factory.define :allowed_technical_component_type do |t|
  t.association :game
end

Factory.define :allowed_generator_type, :class => AllowedGeneratorType,
    :parent => :allowed_technical_component_type do |t|
  t.association :generator_type
  # TODO how can i get buildable type to be set automatically?
  t.buildable_type "GeneratorType"
end

Factory.define :allowed_line_type, :class => AllowedLineType,
    :parent => :allowed_technical_component_type do |t|
  t.association :line_type
  t.buildable_type "LineType"
end

Factory.define :allowed_storage_device_type, :class => AllowedStorageDeviceType,
    :parent => :allowed_technical_component_type do |t|
  t.association :storage_device_type
  t.buildable_type "StorageDeviceType"
end
