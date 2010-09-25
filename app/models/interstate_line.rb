class InterstateLine < ActiveRecord::Base
  belongs_to :incoming_region, :class_name => "Region"
  belongs_to :outgoing_region, :class_name => "Region"
  belongs_to :line_type
  
  scope :with_region, lambda { |region_id|
    { :conditions => ["incoming_region_id = ? or outgoing_region_id = ?",
        region_id, region_id]}
  }

  validates :operating_level, :presence => true
  validates :incoming_region, :presence => true
  validates :outgoing_region, :presence => true
  validates :line_type, :presence => true
end
