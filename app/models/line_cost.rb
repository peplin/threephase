class LineCost < ActiveRecord::Base
  self.inheritance_column = :cost_type
  belongs_to :line_type

  validates :line_type, :presence => true
  validates_presence_of :length_min
  validates_presence_of :length_max
  validates_presence_of :cost_min
  validates_presence_of :cost_max

  def to_s
    "#{cost_type} from #{length_min}m to #{length_max}m is $#{cost_min}-$#{cost_max}"
  end
end

class LineMaintenanceCost < LineCost
end

class LineCapitalCost < LineCost
end
