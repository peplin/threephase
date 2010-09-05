class ResearchAdvancement < ActiveRecord::Base
  belongs_to :region
  validates_presence_of :reason
  validates_presence_of :parameter
  validates_presence_of :adjustment
end
