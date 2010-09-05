class LineCost < ActiveRecord::Base
  self.inheritance_column = :cost_type
  belongs_to :line_type
  validates_presence_of :length_min
  validates_presence_of :length_max
  validates_presence_of :cost_min
  validates_presence_of :cost_max
end

class LineMaintenanceCost < LineCost
end

class LineCapitolCost < LineCost
end
