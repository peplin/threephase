class LineType < ActiveRecord::Base
  acts_as_technical_component
  has_many :line_maintenance_costs
  has_many :line_capitol_costs
  has_many :lines
  has_many :interstate_lines
  validates_presence_of :ac
  validates_presence_of :voltage
  validates_presence_of :resistance
  validates_presence_of :diameter
  validates_presence_of :height
end
