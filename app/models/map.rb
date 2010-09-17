class Map < ActiveRecord::Base
  belongs_to :user
  has_many :regions
  has_many :blocks
  has_friendly_id :name, :use_slug => true

  validates_presence_of :name
  validates_length_of :name, :maximum => 30
end
