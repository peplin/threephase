class Market < ActiveRecord::Base
  has_many :market_prices
  has_many :fuel_types
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true

  def current_price game, zone=nil
    0
  end

  def to_s
    name
  end
end
