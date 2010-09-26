class TechnicalComponentInstance < ActiveRecord::Base
  self.inheritance_column = :instance_type
  has_many :repairs, :as => :repairable, :dependent => :destroy
  belongs_to :buildable, :polymorphic => true
  belongs_to :zone

  validates :operating_level, :presence => true, :percentage => true
  validates :zone, :presence => true

  def region
    zone.region
  end

  def to_s
    "#{buildable} created #{created_at} operating at #{operating_level}%"
  end
end
