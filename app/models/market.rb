class Market < ActiveRecord::Base
  has_many :market_prices
  has_many :fuel_types
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true
  validates :average_price, :presence => true,
      :numericality => {:greater_than => 0}
  validates :standard_deviation, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}

  def current_price game, city=nil
    market_price = market_prices.order(:created_at).find_by_game_id(game)
    market_price.price if market_price
    0.0
  end

  def initialize_for game
  end

  def to_s
    name
  end
end
