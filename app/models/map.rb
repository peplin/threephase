class Map < ActiveRecord::Base
  belongs_to :user
  has_many :regions
  has_many :blocks
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true, :length => {:maximum => 30}

  def to_s
    name
  end
end
