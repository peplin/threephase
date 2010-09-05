class TechnicalComponent < ActiveRecord::Base
  belongs_to :buildable, :polymorphic => true, :dependent => :destroy
  belongs_to :user
  validates_presence_of :name
  validates_presence_of :peak_capacity_min
  validates_presence_of :peak_capacity_max
  validates_presence_of :average_capacity
  validates_presence_of :mtbf
  validates_presence_of :mttr
  validates_presence_of :repair_cost
  validates_presence_of :workforce
  validates_presence_of :area
  validates_presence_of :capitol_cost_min
  validates_presence_of :capitol_cost_max
  validates_presence_of :environmental_disruptiveness
  validates_presence_of :waste_disposal_cost_min
  validates_presence_of :waste_disposal_cost_max
  validates_presence_of :noise
  validates_presence_of :operating
  validates_presence_of :lifetime
end
