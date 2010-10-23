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
    if market_price
      market_price.price
    else
      0.0
    end
  end

  def initialize_for game
    positive = rand >= 0.5
    deviation = rand * standard_deviation
    deviation *= -1 if not positive
    market_prices.create :game => game, :price => (average_price + deviation)
  end

  def to_s
    name
  end
end
