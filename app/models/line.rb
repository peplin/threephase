class Line < TechnicalComponentInstance
  belongs_to :line_type, :foreign_key => "buildable_id"
  belongs_to :other_zone, :class_name => "Zone"
  belongs_to :ending_zone, :class_name => 'Zone', :foreign_key => "other_zone"
end
