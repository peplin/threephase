class LoadProfile < ActiveRecord::Base
  belongs_to :zone
  validates_presence_of :hour
  validates_presence_of :demand
end
