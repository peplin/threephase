class Zone < ActiveRecord::Base
  belongs_to :region
  has_many :blips
  has_many :load_profiles
  has_many :generators
  has_many :lines
  has_many :storage_devices

  validates_presence_of :name
  validates_presence_of :x
  validates_presence_of :y
end
