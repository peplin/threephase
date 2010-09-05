class FuelContract < ActiveRecord::Base
  belongs_to :proposing_region, :class_name => "Region"
  belongs_to :receiving_region, :class_name => "Region"
  belongs_to :fuel

  validates_presence_of :price_per_unit
  validates_presence_of :amount
  validates_presence_of :duration
end
