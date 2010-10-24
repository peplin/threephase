class AverageOperatingLevel < ActiveRecord::Base
  belongs_to :technical_component_instance

  validates :operating_level, :presence => true, :percentage => true
  validates :technical_component_instance, :presence => true
end
