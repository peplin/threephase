class LineType < ActiveRecord::Base
  acts_as_technical_component
  has_many :line_maintenance_costs
  has_many :line_capital_costs
  has_many :lines, :foreign_key => "buildable_id"
  has_many :interstate_lines

  validates :ac, :presence => true
  validates :voltage, :presence => true, :numericality => {:greater_than => 0}
  validates :resistance, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0}
  validates :diameter, :presence => true, :numericality => {:greater_than => 0,
      :less_than_or_equal_to => 25}
  validates :height, :presence => true, :numericality => {
      :greater_than_or_equal_to => -25, :less_than_or_equal_to => 100}

  def to_s
    "#{super}, #{voltage}kV #{(ac ? 'AC' : 'DC')}"
  end
end
