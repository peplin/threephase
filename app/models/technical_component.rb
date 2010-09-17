class TechnicalComponent < ActiveRecord::Base
  belongs_to :buildable, :polymorphic => true, :dependent => :destroy
  belongs_to :user
  has_many :technical_component_instances, :as => :buildable

  validates :name, :presence => true
  validates :peak_capacity_min, :presence => true
  validates :peak_capacity_max, :presence => true
  validates :average_capacity, :presence => true, :percentage => true
  validates :mtbf, :presence => true
  validates :mttr, :presence => true
  validates :repair_cost, :presence => true, :percentage => true
  validates :workforce, :presence => true
  validates :area, :presence => true
  validates :capitol_cost_min, :presence => true
  validates :capitol_cost_max, :presence => true
  validates :environmental_disruptiveness, :presence => true,
      :percentage => true
  validates :waste_disposal_cost_min, :presence => true
  validates :waste_disposal_cost_max, :presence => true
  validates :noise, :presence => true
  validates :lifetime, :presence => true
end
