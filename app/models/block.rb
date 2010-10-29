require 'distance'

class Block < ActiveRecord::Base
  include CoordinateDistance
  NATURAL_RESOURCES = [:coal, :oil, :natural_gas, :sun, :wind, :water]

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

  NATURAL_RESOURCES.each do |index|
    # this isn't as DRY as it could be, because we can't call the class method
    # while creating the class.
    attr_readonly "#{index.to_s}_index".to_sym
  end

  validates :block_type, :presence => true
  enum_attr :block_type, [:mountain, :water, :plains]
  validates :map, :presence => true

  before_validation :generate_natural_resource_indicies, :on => :create

  def distance other_x, other_y
    coordinate_distance x, y, other_x, other_y
  end

  def natural_resource_index(resource)
    attributes[attribute_for_index(resource)]
  end

  def to_s
    "(#{x}, #{y}) #{block_type}"
  end

  private

  def attribute_for_index index
    "#{index.to_s}_index"
  end

  def generate_natural_resource_indicies
    NATURAL_RESOURCES.each do |index|
      next if attributes[attribute_for_index(index)]
      write_attribute(attribute_for_index(index), rand(100))
      # TODO be smarter about random value, and really never use this, since the
      # map should set it while taking into account the topology
    end
  end
end
