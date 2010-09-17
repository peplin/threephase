class InterstateLine < ActiveRecord::Base
  belongs_to :incoming_region, :class_name => "Region"
  belongs_to :outgoing_region, :class_name => "Region"
  belongs_to :line_type
  has_friendly_id :regions_and_type, :use_slug => true

  validates_presence_of :accepted

  def regions_and_type 
    #{incoming_region} #{outgoing_region} #{line_type}
  end
end
