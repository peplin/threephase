module FindNearestZoneExtension
  def find_nearest x, y
    shortest_distance = nil
    nearest = nil
    find(:all).each do |zone|
      distance = zone.distance x, y
      if shortest_distance == nil or distance < shortest_distance
        shortest_distance = distance
        nearest = zone
      end
    end
    nearest
  end

  def find_nearest_to_zone zone
    find_nearest zone.x, zone.y
  end
end

class Region < ActiveRecord::Base
  # Don't place zones any closer than this
  ZONE_BUFFER = 50

  has_many :research_advancements
  has_many :outgoing_interstate_lines, :class_name => "InterstateLine",
      :foreign_key => "outgoing_region_id"
  has_many :incoming_interstate_lines, :class_name => "InterstateLine",
      :foreign_key => "incoming_region_id"
  has_many :zones, :extend => FindNearestZoneExtension
  belongs_to :map
  belongs_to :game
  belongs_to :user

  validates :name, :presence => true
  validates :research_budget, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}
  validates :map, :presence => true
  validates :game, :presence => true
  validates :user, :presence => true

  after_create :generate_starting_zones

  def interstate_lines
    InterstateLine.with_region(id)
  end

  def repairs
    zones.collect do |z|
      z.repairs
    end.flatten
  end

  def bids
    zones.collect do |z|
      z.bids
    end.flatten
  end

  def contracts
    zones.collect do |z|
      z.contracts
    end.flatten
  end

  def next_free_coordinates
    begin
      x = rand(map.width)
      y = rand(map.height)
    end while (zones.count > 0 and
        zones.find_nearest(x, y).distance(x, y) < ZONE_BUFFER)
    [x, y]
  end

  def to_s
    name
  end

  private

  def generate_starting_zones
    (1 + rand(4)).times do
      self.zones << Zone.new
    end
  end
end
