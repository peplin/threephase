class LineType < ActiveRecord::Base
  acts_as_technical_component
  has_many :line_costs
end
