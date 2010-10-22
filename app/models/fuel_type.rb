class FuelType < ActiveRecord::Base
  belongs_to :market
  has_many :generator_types
  has_many :market_prices, :through => :market
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true

  def to_s
    name
  end
end
