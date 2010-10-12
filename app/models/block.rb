class Block < ActiveRecord::Base
  belongs_to :map
  has_many :wind_profiles

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
  validates :map, :presence => true

  def to_s
    "(#{x}, #{y}) #{type}"
  end
end
