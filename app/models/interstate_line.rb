class InterstateLine < ActiveRecord::Base
  belongs_to :incoming_region, :class_name => "Region"
  belongs_to :outgoing_region, :class_name => "Region"
  belongs_to :line_type
  #TODO
  #has_friendly_id :regions_and_type, :use_slug => true

  #def regions_and_type 
  #  #{incoming_region} #{outgoing_region} #{line_type}
  #end
  #
  named_scope :with_region, lambda { |region_id|
    { :conditions => ["incoming_region_id = ? or outgoing_region_id = ?",
        region_id, region_id]}
  }
end
