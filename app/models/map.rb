class Map < ActiveRecord::Base
  WIDTH = 600
  HEIGHT = 400
  belongs_to :user
  has_many :states
  has_many :blocks
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true, :length => {:maximum => 30}

  after_create :attach_blocks

  def height
    HEIGHT
  end

  def width
    WIDTH
  end

  def to_s
    name
  end

  private

  def attach_blocks
    (0..width).each do |x|
      next unless x % 50 == 0
      (0..height).each do |y|
        next unless y % 50 == 0
        self.blocks.create(:x => x, :y => y)
      end
    end
  end
end
