class PeakDemand < ActiveRecord::Base
  belongs_to :city

  validates :peak_demand, :presence => true, :percentage => true
  validates :city, :presence => true
end
