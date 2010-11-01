require 'distance'
require 'simple'
require 'natural_resources'
require 'query_extensions'

class City < ActiveRecord::Base
  include CoordinateDistance
  include SimpleExtensions
  include NaturalResources

  DEMAND_SCALE_FACTOR = 1000.0

  belongs_to :state
  has_many :generators
  has_many :bids, :through => :generators
  has_many :outgoing_lines, :class_name => "Line", :foreign_key => "city_id"
  has_many :incoming_lines, :class_name => "Line",
      :foreign_key => "other_city_id"
  has_many :peak_demands, :extend => [FindByDayExtension, FindLatestExtension]
  has_many :marginal_prices,
      :extend => [FindByDayExtension, FindLatestExtension]
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
  after_create :add_historical_peak_demand

  def lines
    Line.with_city(id)
  end

  def map
    state.map
  end
  
  def game
    state.game
  end

  def demand time=nil
    time ||= Time.now
    ((-0.1 * ((0.42 * time.hour - 5) ** 4) + 100) *
        customers / DEMAND_SCALE_FACTOR).to_int
  end

  def load_profile
    (0..23).collect do |hour|
      demand(Time.now.at_beginning_of_day + hour.hour)
    end
  end

  def peak_demand time=nil
    if not time
      peak = load_profile.max
      if peak != peak_demands.latest.first.peak_demand
        peak_demands.create :peak_demand => peak
      end
    else
      peak = peak_demands.find_by_day(time)
    end
    peak
  end

  def demanded_since time
    # TODO would be nice to do this with an integral
    ((time.to_i + 10.minutes)..Time.now.utc.to_i
        ).step(10.minutes).inject(0) do |total, hour|
      total + demand(Time.at(hour)) / 6.0
    end.ceil
  end

  def cost_since time
    generators.inject(0) do |cost, generator|
      cost = generator.cost_since(time)
    end
  end

  def repairs
    [generators, lines].collect do |instances|
      instances.collect(&:repairs).flatten
    end.flatten!
  end

  def distance other_x, other_y
    coordinate_distance x, y, other_x, other_y
  end
  
  def distance_to_city city
    distance city.x, city.y
  end

  def current_price market, time=nil
    market.current_local_price self, time
  end

  def to_s
    "#{name} (#{x}, #{y})"
  end

  private

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

  def add_historical_peak_demand
    self.peak_demands.create :peak_demand => load_profile.max
  end

  def calculate_natural_resource_indicies
    Block::NATURAL_RESOURCES.each do |index|
      write_attribute(attribute_for_index(index),
          map.natural_resource_index(index, x, y,
          range_map(customers, 0, 1000, 0, map.width / 4.0)))
      # TODO use better customer range
    end
  end
end
