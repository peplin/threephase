class Zone < ActiveRecord::Base
  belongs_to :region
  has_many :blips
  has_many :load_profiles
  has_many :generators
  has_many :lines
  has_many :storage_devices
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true
  validates :x, :presence => true, :numericality => {:greater_than => -1}
  validates :y, :presence => true, :numericality => {:greater_than => -1}
  validates :region, :presence => true

  attr_readonly :x, :y, :region

  after_create :generate_load_profiles
  before_validation :generate_name, :on => :create
  before_validation :generate_coordinates, :on => :create

  def demand
  end

  def repairs
    [generators, lines, storage_devices].collect do |instances|
      instances.collect do |i|
        i.repairs
      end
    end.flatten!
  end

  def bids
    generators.collect do |g|
      g.bids
    end.flatten!
  end

  def contracts
    generators.collect do |g|
      g.contracts
    end.flatten!
  end

  def distance other_x, other_y
    Math.sqrt(((other_x - x) ** 2) + ((other_y - y) ** 2))
  end
  
  def distance_to_zone zone
    distance zone.x, zone.y
  end

  def to_s
    "#{name} (#{x}, #{y})"
  end

  private

  def generate_load_profiles
    24.times do |hour|
      self.load_profiles << LoadProfile.new(:hour => hour)
    end
  end

  def generate_name
    self.name = "A Zone" unless self.name
  end

  def generate_coordinates
    self.x, self.y = region.next_free_coordinates unless (
        self.x and self.y or not region)
  end
end
