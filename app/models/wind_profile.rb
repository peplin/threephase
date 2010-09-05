class WindProfile < ActiveRecord::Base
  belongs_to :block
  validates_presence_of :hour
  validates_presence_of :speed
end
