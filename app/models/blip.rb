class Blip < ActiveRecord::Base
  belongs_to :zone
  validates_presence_of :x
  validates_presence_of :y
  validates_presence_of :power_factor
end
