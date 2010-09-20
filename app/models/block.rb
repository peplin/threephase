class Block < ActiveRecord::Base
  belongs_to :map
  validates_presence_of :x
  validates_presence_of :y
  validates_presence_of :elevation
  validates_presence_of :wind_speed
  validates_presence_of :water_flow
  validates_presence_of :sunfall
  validates_presence_of :natural_gas_index
  validates_presence_of :coal_index

  validates :type, :presence => true
  enum_attr :type, [:mountain, :water, :plains]
end
