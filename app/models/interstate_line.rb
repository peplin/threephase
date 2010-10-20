class InterstateLine < ActiveRecord::Base
  belongs_to :incoming_state, :class_name => "State"
  belongs_to :outgoing_state, :class_name => "State"
  belongs_to :line_type
  
  scope :with_state, lambda { |state_id|
    { :conditions => ["incoming_state_id = ? or outgoing_state_id = ?",
        state_id, state_id]}
  }

  validates :line_type, :presence => true
  validates :incoming_state, :presence => true
  validates :outgoing_state, :presence => true
  validates :operating_level, :presence => true
  validates_with LineEndpointValidator, :start => :incoming_state,
      :end => :outgoing_state

  attr_readonly :incoming_state, :outgoing_state, :line_type

  def accepted= response
    if new_record? or not accepted
      write_attribute(:accepted, response)
    else
      raise "response cannot be changed once submitted"
    end
  end

  def to_s
    "#{line_type} from #{incoming_state} to #{outgoing_state} operating at #{operating_level}"
  end
end
