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

  validates :block_type, :presence => true
  enum_attr :block_type, [:mountain, :water, :plains]
  validates :map, :presence => true

  after_create :generate_wind_profiles

  def to_s
    "(#{x}, #{y}) #{block_type}"
  end

  private

  def generate_wind_profiles
    (0..23).each do |hour|
      self.wind_profiles << WindProfile.new(:hour => hour)
    end
  end
end
