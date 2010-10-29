class TechnicalComponentInstance < ActiveRecord::Base
  self.inheritance_column = :instance_type
  has_many :repairs, :as => :repairable, :dependent => :destroy
  has_many :average_operating_levels do
    def find_by_day time
      find(:all, :conditions => {
          :created_at => time.at_beginning_of_day..time.end_of_day}).first
    end
  end
  belongs_to :buildable, :polymorphic => true
  belongs_to :city

  validates :operating_level, :presence => true, :percentage => true
  validates :city, :presence => true
  has_one :state, :through => :city

  after_create :add_average_operating_level

  def game
    state.game
  end

  def operated_hours time
    game.time_since(time) / 1.hour
  end

  def average_operating_level time=nil
    time ||= Time.now
    level = average_operating_levels.find_by_day(time)
    level ? level.operating_level : 0
  end

  def step
  end

  def to_s
    "#{buildable} created #{created_at} operating at #{operating_level}%"
  end

  private

  def add_average_operating_level
    self.average_operating_levels.create(:operating_level => operating_level)
  end
end
