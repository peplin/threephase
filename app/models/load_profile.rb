class LoadProfile < ActiveRecord::Base
  belongs_to :zone

  validates_presence_of :hour
  validates_presence_of :demand
  validates :zone, :presence => true

  before_save :calculate_demand

  def to_s
    "#{demand} MW @ #{hour}:00"
  end

  private

  def calculate_demand
    demand = 0
    if (8..23).to_a.include? hour:
      # oversimplified parabola
      demand = -0.1 * ((hour - 15) ** 2) + 1
    end
  end
end
