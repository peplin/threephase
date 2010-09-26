class WindProfile < ActiveRecord::Base
  belongs_to :block

  validates_presence_of :hour
  validates_presence_of :speed
  validates :block, :presence => true

  def to_s
    "#{speed} m/s @ #{hour}:00"
  end
end
