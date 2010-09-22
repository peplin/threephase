class TechnicalComponentInstance < ActiveRecord::Base
  self.inheritance_column = :instance_type
  has_many :repairs, :as => :repairable, :dependent => :destroy
  belongs_to :buildable, :polymorphic => true
  belongs_to :zone

  validates :operating, :presence => true
  validates :operating_level, :presence => true, :percentage => true
  validates :zone, :presence => true
end
