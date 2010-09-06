class StorageDeviceType < ActiveRecord::Base
  acts_as_technical_component
  has_many :storage_devices, :foreign_key => "buildable_id"
  validates_presence_of :decay_rate
  validates_presence_of :efficiency
end
