class TechnicalComponentInstance < ActiveRecord::Base
  self.inheritance_column = :instance_type
  has_many :repairs, :as => :repairable, :dependent => :destroy
  has_many :average_operating_levels
  belongs_to :buildable, :polymorphic => true
  belongs_to :city

  validates :operating_level, :presence => true, :percentage => true
  validates :city, :presence => true

  def state
    city.state
  end

  def game
    state.game
  end

  def operated_hours time
    game.time_since(time) / 1.hour
  end

  def step
  end

  def to_s
    "#{buildable} created #{created_at} operating at #{operating_level}%"
  end
end
