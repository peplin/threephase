class Market < ActiveRecord::Base
  has_many :market_prices
  has_many :fuels

  validates :price, :presence => true
end
