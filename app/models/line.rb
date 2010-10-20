class Line < TechnicalComponentInstance
  belongs_to :line_type, :foreign_key => "buildable_id"
  belongs_to :city, :class_name => "City"
  belongs_to :other_city, :class_name => "City"

  scope :with_city, lambda { |city_id|
    { :conditions => ["city_id = ? or other_city_id = ?", city_id, city_id]}
  }

  validates :line_type, :presence => true
  validates :city, :presence => true
  validates :other_city, :presence => true
  validates_with LineEndpointValidator, :start => :city, :end => :other_city
end
