class MarginalPrice < ActiveRecord::Base
  belongs_to :state

  validates :marginal_price, :presence => true
  validates :state, :presence => true
end
