class Market < ActiveRecord::Base
  has_many :market_prices
  has_many :fuel_types
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true

  def current_price game, city=nil
    market_price = market_prices.order(:created_at).find_by_game_id(game)
    market_price.price if market_price
    0.0
  end

  def to_s
    name
  end
end
