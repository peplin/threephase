require 'distance'

class Block < ActiveRecord::Base
  include CoordinateDistance

  belongs_to :map
  has_many :wind_profiles

  validates_presence_of :x
  validates_presence_of :y
  validates_presence_of :elevation
  validates :wind_index, :percentage => true, :allow_nil => true
  validates :water_index, :percentage => true, :allow_nil => true
  validates :sun_index, :percentage => true, :allow_nil => true
  validates :natural_gas_index, :percentage => true, :allow_nil => true
  validates :coal_index, :percentage => true, :allow_nil => true
  validates :oil_index, :percentage => true, :allow_nil => true

  attr_readonly :wind_index, :water_index, :sun_index, :natural_gas_index,
      :coal_index, :oil_index

  validates :block_type, :presence => true
  enum_attr :block_type, [:mountain, :water, :plains]
  validates :map, :presence => true

  before_validation :generate_natural_resource_indicies, :on => :create

  def distance other_x, other_y
    coordinate_distance x, y, other_x, other_y
  end

  def natural_resource_index(resource)
    attributes["#{resource.to_s}_index"]
  end

  def to_s
    "(#{x}, #{y}) #{block_type}"
  end

  private

  def generate_natural_resource_indicies
    [:coal_index, :oil_index, :natural_gas_index, :sun_index, :wind_index,
        :water_index].each do |index|
      next if attributes[index]
      write_attribute(index, rand(100))
      # TODO be smarter about random value, and really never use this, since the
      # map should set it while taking into account the topology
    end
  end
end
