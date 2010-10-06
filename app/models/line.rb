class Line < TechnicalComponentInstance
  belongs_to :line_type, :foreign_key => "buildable_id"
  belongs_to :city, :class_name => "City"
  belongs_to :other_city, :class_name => "City"

  validates :line_type, :presence => true
  validates :city, :presence => true
  validates :other_city, :presence => true
end
