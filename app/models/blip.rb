class Blip < ActiveRecord::Base
  belongs_to :zone

  validates :x, :presence => true
  validates :y, :presence => true
  validates :power_factor, :presence => true
  validates :zone, :presence => true
end
