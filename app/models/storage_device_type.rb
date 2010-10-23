class StorageDeviceType < ActiveRecord::Base
  acts_as_technical_component
  has_many :storage_devices, :foreign_key => "buildable_id"

  attr_accessible *TechnicalComponent.attr_accessible
  attr_accessible :decay_rate, :efficiency

  validates :decay_rate, :presence => true
  validates :efficiency, :presence => true, :percentage => true


  def to_s
    "#{technical_component}, #{efficiency}% efficiency"
  end
end
