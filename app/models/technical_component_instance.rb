require 'query_extensions'

class TechnicalComponentInstance < ActiveRecord::Base
  self.inheritance_column = :instance_type
  has_many :repairs, :as => :repairable, :dependent => :destroy
  has_many :average_operating_levels, :autosave => true,
      :extend => FindByDayExtension
  belongs_to :buildable, :polymorphic => true
  belongs_to :city

  validates :city, :presence => true
  has_one :state, :through => :city

  # TODO is there a more sensible way to prime the average operating level?
  after_create :operating_level 

  def game
    state.game
  end

  def operated_hours time
    (game.time.now - time) / 1.hour
  end

  def operating_level time=nil
    if not time
      if not @operating_level
        self.operating_level = city.state.optimal_operating_level self, time
      end
      @operating_level
    else
      city.state.optimal_operating_level self, time
    end
  end

  def operating_level= level
    @operating_level = level
    update_average_operating_level
  end

  def average_operating_level time=nil
    if (time and time <= created_at or
        not level = average_operating_levels.find_by_day(time))
      0
    else
      level.operating_level
    end
  end

  def step
  end

  def to_s
    "#{buildable} created #{created_at} operating at #{operating_level}%"
  end

  private

  def update_average_operating_level
    today = game.time.now.to_date
    average_level = average_operating_levels.find_by_day(today)
    if average_level and average_level.created_at.to_date == today
      average_level.refresh(@operating_level)
      average_level.save
    else
      self.average_operating_levels.create(:operating_level => operating_level)
    end
  end
end
