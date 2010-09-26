class LoadProfile < ActiveRecord::Base
  belongs_to :zone

  validates_presence_of :hour
  validates_presence_of :demand
  validates :zone, :presence => true

  def to_s
    "#{demand} MW @ #{hour}:00"
  end
end
