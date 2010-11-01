class MarginalPrice < ActiveRecord::Base
  belongs_to :city

  validates :marginal_price, :presence => true
  validates :city, :presence => true
end
