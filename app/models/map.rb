class Map < ActiveRecord::Base
  WIDTH = 600
  HEIGHT = 400
  belongs_to :user
  has_many :states
  has_many :blocks
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true, :length => {:maximum => 30}

  def height
    HEIGHT
  end

  def width
    WIDTH
  end

  def to_s
    name
  end
end
