require 'query_extensions'
require 'simple'

class TechnicalComponentInstance < ActiveRecord::Base
  include SimpleExtensions
  self.inheritance_column = :instance_type

  has_one :state, :through => :city
  has_many :repairs, :as => :repairable, :dependent => :destroy
  has_many :average_operating_levels, :autosave => true,
      :extend => FindByDayExtension
  belongs_to :buildable, :polymorphic => true
  belongs_to :city

  validates :city, :presence => true
  validates :capacity, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}
  validate :within_capacity_limits

  before_validation :set_capacity, :on => :create

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
        not level = average_operating_levels.find_by_day(game, time))
      0
    else
      level.operating_level
    end
  end

  def capital_cost
    range_map(capacity,
      buildable.peak_capacity_min,
      buildable.peak_capacity_max,
      buildable.capital_cost_min,
      buildable.capital_cost_max)
  end

  def waste_disposal_cost
    range_map(capacity,
      buildable.peak_capacity_min,
      buildable.peak_capacity_max,
      buildable.waste_disposal_cost_min,
      buildable.waste_disposal_cost_max)
  end

  def step
  end

  def to_s
    "#{buildable} created #{created_at_in_game} operating at #{operating_level}%"
  end

  def created_at_in_game
    game.time.at(created_at)
  end

  def updated_at_in_game
    game.time.at(updated_at)
  end

  private

  def within_capacity_limits
    if (capacity > buildable.peak_capacity_max or
        capacity < buildable.peak_capacity_min)
      errors[:capacity] << "capacity must be within the range of the type"
    end if capacity
  end

  def set_capacity
    if buildable and not capacity
      self.capacity = range_map(50, 0, 100, self.buildable.peak_capacity_min,
          self.buildable.peak_capacity_max)
    end
  end

  def update_average_operating_level
    average_level = average_operating_levels.find_by_day(game, game.time.now)
    if (average_level and 
        game.time.at(average_level.created_at).to_date == game.time.now.to_date)
      average_level.refresh(@operating_level)
      average_level.save
    else
      self.average_operating_levels.create(:operating_level => operating_level)
    end
  end
end
