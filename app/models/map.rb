class Map < ActiveRecord::Base
  WIDTH = 600
  HEIGHT = 400
  belongs_to :user
  has_many :states
  has_many :blocks do
    def near(x, y, radius)
      find(:all).collect do |block|
        block if block.distance(x, y) <= radius
      end.compact
    end
  end
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true, :length => {:maximum => 30}

  after_create :attach_blocks

  def natural_resource_index index, x=nil, y=nil, radius=nil
    # TODO if this doesn't change, cache it on map creation
    if x and y and radius
      block_set = blocks.near(x, y, radius)
    else
      block_set = blocks
    end

   block_set.inject(0) {|total, block|
      total + block.natural_resource_index(:coal)
    }
  end

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
    step = ::Rails.env == "test" ? 100 : 20
    (0..width).each do |x|
      next unless x % step == 0
      (0..height).each do |y|
        next unless y % step == 0
        self.blocks.create(:x => x, :y => y,
            :block_type => (Block.new.block_types[
                rand(Block.new.block_types.length)]))
      end
    end
  end
end
