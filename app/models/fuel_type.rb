class FuelType < ActiveRecord::Base
  belongs_to :market
  has_many :generator_types
  has_many :generators, :through => :generator_types
  has_many :market_prices, :through => :market
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true

  def average_demand game, time=nil
  end

  def demand game
  end

  def to_s
    name
  end
end
