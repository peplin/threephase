class Line < TechnicalComponentInstance
  belongs_to :line_type, :foreign_key => "buildable_id"
  belongs_to :zone, :class_name => "Zone"
  belongs_to :other_zone, :class_name => "Zone"

  validates :line_type, :presence => true
  validates :zone, :presence => true
  validates :other_zone, :presence => true
end
