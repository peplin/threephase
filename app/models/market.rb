class Market < ActiveRecord::Base
  has_many :market_prices
  has_many :fuel_types
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true
end
