class ResearchAdvancement < ActiveRecord::Base
  belongs_to :state

  validates_presence_of :reason
  validates_presence_of :parameter
  validates_presence_of :adjustment
  validates :state, :presence => true

  def to_s
    "#{reason} adjusts #{parameter} by #{adjustment}"
  end
end
