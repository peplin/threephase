require 'simple'

class AverageOperatingLevel < ActiveRecord::Base
  include SimpleExtensions

  belongs_to :technical_component_instance

  validates :operating_level, :presence => true
  validates :technical_component_instance, :presence => true

  def normalized_operating_level new_operating_level
    old_hours = game.time.at(updated_at).hour + 1
    new_hours = game.time.now.hour + 1
    normalized_average operating_level, new_operating_level, old_hours,
        new_hours
  end

  def game
    technical_component_instance.game
  end

  def refresh new_operating_level
    self.operating_level = normalized_operating_level(new_operating_level)
  end
end
