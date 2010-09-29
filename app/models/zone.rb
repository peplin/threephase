class Zone < ActiveRecord::Base
  belongs_to :region
  has_many :blips
  has_many :load_profiles
  has_many :generators
  has_many :lines
  has_many :storage_devices
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true
  validates :x, :presence => true, :numericality => {:greater_than => -1}
  validates :y, :presence => true, :numericality => {:greater_than => -1}
  validates :region, :presence => true

  def demand
  end

  def repairs
    [generators, lines, storage_devices].collect do |instances|
      instances.collect do |i|
        i.repairs
      end
    end.flatten
  end

  def bids
    generators.collect do |g|
      g.bids
    end
  end

  def contracts
    generators.collect do |g|
      g.contracts
    end
  end

  def to_s
    "#{name} (#{x}, #{y})"
  end
end
