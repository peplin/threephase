class FuelContract < ActiveRecord::Base
  belongs_to :proposing_region, :class_name => "Region"
  belongs_to :receiving_region, :class_name => "Region"
  belongs_to :fuel
end
