class InterstateLine < ActiveRecord::Base
  belongs_to :proposing_region, :class_name => "Region"
  belongs_to :receiving_region, :class_name => "Region"
  belongs_to :line_type
  validates_presence_of :accepted
end
