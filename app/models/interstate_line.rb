class InterstateLine < ActiveRecord::Base
  belongs_to :incoming_region, :class_name => "Region"
  belongs_to :outgoing_region, :class_name => "Region"
  belongs_to :line_type
  
  scope :with_region, lambda { |region_id|
    { :conditions => ["incoming_region_id = ? or outgoing_region_id = ?",
        region_id, region_id]}
  }

  validates :line_type, :presence => true
  validates :incoming_region, :presence => true
  validates :outgoing_region, :presence => true
  validates :operating_level, :presence => true

  attr_readonly :incoming_region, :outgoing_region, :line_type

  def accepted= response
    if new_record? or not accepted
      write_attribute(:accepted, response)
    else
      raise "response cannot be changed once submitted"
    end
  end

  def to_s
    "#{line_type} from #{incoming_region} to #{outgoing_region} operating at #{operating_level}"
  end
end
