class AverageOperatingLevel < ActiveRecord::Base
  belongs_to :technical_component_instance

  validates :operating_level, :presence => true, :percentage => true
  validates :technical_component_instance, :presence => true

  def refresh new_operating_level
    old_hours = updated_at.hour + 1
    new_hours = Time.now.utc.hour + 1
    # TODO use game time! game time should return UTC
    if new_hours == old_hours
      new_average = operating_level - Float(operating_level) / old_hours
      new_average += Float(new_operating_level) / old_hours
    else
      new_average = Float(operating_level) / new_hours * old_hours
      new_average += Float(new_operating_level) / new_hours *
          (new_hours - old_hours)
    end
    self.operating_level = new_average
    save
  end
end
