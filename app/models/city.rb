class City < ActiveRecord::Base
  belongs_to :state
  has_many :customers
  has_many :load_profiles
  has_many :generators
  has_many :outgoing_lines, :class_name => "Line", :foreign_key => "city_id"
  has_many :incoming_lines, :class_name => "Line", :foreign_key => "other_city_id"
  has_many :storage_devices
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true
  validates :x, :presence => true, :numericality => {:greater_than => -1}
  validates :y, :presence => true, :numericality => {:greater_than => -1}
  validates :state, :presence => true

  attr_readonly :x, :y, :state

  after_create :generate_load_profiles
  before_validation :generate_name, :on => :create
  before_validation :generate_coordinates, :on => :create

  def lines
    Line.with_city(id)
  end

  def demand
    0
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

  def power_factor
    power_factors = customers.collect do |c|
      c.power_factor
    end
    power_factors.inject(0.0) { |sum, el| sum + el } / power_factors.size
  end

  def distance other_x, other_y
    Math.sqrt(((other_x - x) ** 2) + ((other_y - y) ** 2))
  end
  
  def distance_to_city city
    distance city.x, city.y
  end

  def to_s
    "#{name} (#{x}, #{y})"
  end

  private

  def generate_load_profiles
    (0..23).each do |hour|
      self.load_profiles << LoadProfile.new(:hour => hour)
    end
  end

  def generate_name
    self.name = "A City" unless self.name
  end

  def generate_coordinates
    self.x, self.y = state.next_free_coordinates unless (
        self.x and self.y or not state)
  end
end
