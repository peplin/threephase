module FindNearestCityExtension
  def find_nearest x, y
    shortest_distance = nil
    nearest = nil
    find(:all).each do |city|
      distance = city.distance x, y
      if shortest_distance == nil or distance < shortest_distance
        shortest_distance = distance
        nearest = city
      end
    end
    nearest
  end

  def find_nearest_to_city city
    find_nearest city.x, city.y
  end
end

class State < ActiveRecord::Base
  # Don't place cities any closer than this
  CITY_BUFFER = 50

  has_many :research_advancements
  has_many :outgoing_interstate_lines, :class_name => "InterstateLine",
      :foreign_key => "outgoing_state_id"
  has_many :incoming_interstate_lines, :class_name => "InterstateLine",
      :foreign_key => "incoming_state_id"
  has_many :cities, :extend => FindNearestCityExtension
  belongs_to :map
  belongs_to :game
  belongs_to :user

  validates :name, :presence => true
  validates :research_budget, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}
  validates :cash, :numericality => {:greater_than_or_equal_to => 0},
      :allow_nil => true
  validates :map, :presence => true
  validates :game, :presence => true
  validates :user, :presence => true

  before_create :generate_starting_cash
  after_create :generate_starting_cities

  def interstate_lines
    InterstateLine.with_state(id)
  end

  def repairs
    cities.collect do |z|
      z.repairs
    end.flatten
  end

  def bids
    cities.collect do |z|
      z.bids
    end.flatten
  end

  def generators
    cities.collect do |z|
      z.generators
    end.flatten
  end

  def lines
    cities.collect do |z|
      z.lines
    end.flatten
  end

  def storage_devices
    cities.collect do |z|
      z.storage_devices
    end.flatten
  end

  def next_free_coordinates
    begin
      x = rand(map.width)
      y = rand(map.height)
    end while (cities.count > 0 and
        cities.find_nearest(x, y).distance(x, y) < CITY_BUFFER)
    [x, y]
  end

  def step
  end

  def to_s
    name
  end

  private

  def generate_starting_cash
    cash = game.starting_capital
  end

  def generate_starting_cities
    (1 + rand(4)).times do
      self.cities << City.new
    end
  end
end
