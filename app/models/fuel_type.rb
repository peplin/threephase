class FuelType < ActiveRecord::Base
  belongs_to :market
  has_many :generator_types
  has_many :market_prices, :through => :market

  validates :name, :presence => true
end
