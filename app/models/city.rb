require 'distance'
require 'simple'

class City < ActiveRecord::Base
  include CoordinateDistance
  include SimpleExtensions

  belongs_to :state
  has_many :load_profiles do
    def find_at_time time
      find_by_hour(time.hour)
    end
  end
  has_many :generators
  has_many :bids, :through => :generators
  has_many :outgoing_lines, :class_name => "Line", :foreign_key => "city_id"
  has_many :incoming_lines, :class_name => "Line", :foreign_key => "other_city_id"
  has_many :storage_devices
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true
  validates :x, :presence => true, :numericality => {:greater_than => -1}
  validates :y, :presence => true, :numericality => {:greater_than => -1}
  validates :state, :presence => true
  validates :customers, :numericality => {:greater_than => 0},
      :allow_nil => :true

  attr_readonly :x, :y, :state

  before_validation :generate_name, :on => :create
  before_validation :generate_coordinates, :on => :create
  before_create :add_customers
  before_create :calculate_natural_resource_indicies
  after_create :generate_load_profiles

  def lines
    Line.with_city(id)
  end

  def map
    state.map
  end

  def demand time=nil
    time ||= Time.now
    load_profiles.find_at_time(time).demand
  end

  def repairs
    [generators, lines, storage_devices].collect do |instances|
      instances.collect do |i|
        i.repairs
      end
    end.flatten!
  end

  def distance other_x, other_y
    coordinate_distance x, y, other_x, other_y
  end
  
  def distance_to_city city
    distance city.x, city.y
  end

  def step
  end

  def current_price market
    market.current_local_price self
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

  def add_customers
    # TODO something better.
    self.customers ||= rand(1000)
  end

  def calculate_natural_resource_indicies
    [:coal, :oil, :natural_gas, :sun, :wind, :water].each do |index|
      write_attribute("#{index.to_s}_index", map.natural_resource_index(
          index, x, y, range_map(customers, 0, 1000, 0, map.width / 4.0)))
      # TODO use better customer range
    end
  end
end
