class Repair < ActiveRecord::Base
  belongs_to :repairable, :polymorphic => true

  validates_presence_of :reason
  validates_presence_of :cost
  validates_presence_of :duration
  validates :repairable, :presence => true

  def to_s
    "#{reason} for $#{cost}"
  end
end
