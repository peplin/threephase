class Market < ActiveRecord::Base
  has_many :market_prices
  has_many :fuel_types

  validates :name, :presence => true
end
