class PeakDemand < ActiveRecord::Base
  belongs_to :city

  validates :peak_demand, :presence => true
  validates :city, :presence => true
end
