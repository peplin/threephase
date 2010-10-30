class LoadProfile < ActiveRecord::Base
  belongs_to :city

  validates_presence_of :hour
  validates_presence_of :demand
  validates :city, :presence => true

  before_validation :calculate_demand, :on => :create

  def to_s
    "#{demand} MW @ #{hour}:00"
  end

  private

  def calculate_demand
    if (8..23).to_a.include? self.hour
      # oversimplified parabola
      self.demand = -0.1 * ((0.42 * self.hour - 5) ** 4) + 100
    end
  end
end
