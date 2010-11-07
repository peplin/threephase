class MarketPrice < ActiveRecord::Base
  belongs_to :game
  belongs_to :fuel_market

  scope :closest_to, lambda { |date|
    # TODO this should have to be a GameTime
    order(%{ABS(strftime('%s', "#{date.to_normal.to_formatted_s(:db)}") - strftime('%s', created_at)) asc}).
    order("id DESC").
    limit(1)
  }

  validates :price, :presence => true
  validates :game, :presence => true
  validates :fuel_market, :presence => true

  def to_s
    "$#{price}"
  end
end
