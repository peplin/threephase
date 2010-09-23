class StorageDevice < TechnicalComponentInstance
  belongs_to :storage_device_type, :foreign_key => "buildable_id"

  validates :storage_device_type, :presence => true
end
