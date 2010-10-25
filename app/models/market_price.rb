class MarketPrice < ActiveRecord::Base
  belongs_to :game
  belongs_to :fuel_market

  validates :price, :presence => true
  validates :game, :presence => true
  validates :fuel_market, :presence => true

  def to_s
    "$#{price}"
  end
end
