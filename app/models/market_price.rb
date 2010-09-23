class MarketPrice < ActiveRecord::Base
  belongs_to :game
  belongs_to :market

  validates :price, :presence => true
  validates :game, :presence => true
  validates :market, :presence => true
end
