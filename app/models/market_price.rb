class MarketPrice < ActiveRecord::Base
  belongs_to :game
  belongs_to :market

  validates_presence_of :price
end
