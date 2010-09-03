class LineCost < ActiveRecord::Base
  self.inheritance_column = :cost_type
  belongs_to :line_type
end

class LineMaintenanceCost < LineCost
end

class LineCapitolColst < LineCost
end
