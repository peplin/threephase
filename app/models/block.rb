class Block < ActiveRecord::Base
  belongs_to :map
  has_many :wind_profiles

  validates_presence_of :x
  validates_presence_of :y
  validates_presence_of :elevation
  validates_presence_of :wind_index
  validates_presence_of :water_index
  validates_presence_of :sun_index
  validates_presence_of :natural_gas_index
  validates_presence_of :coal_index
  validates_presence_of :oil_index

  validates :block_type, :presence => true
  enum_attr :block_type, [:mountain, :water, :plains]
  validates :map, :presence => true

  def to_s
    "(#{x}, #{y}) #{block_type}"
  end
end
