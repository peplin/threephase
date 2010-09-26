class ContractNegotiation < ActiveRecord::Base
  belongs_to :generator
  has_many :contract_offers

  validates :reason, :presence => true
  validates :amount, :presence => true
  validates :generator, :presence => true

  def to_s
    "#{reason} with #{contract_offers.count} offers"
  end
end
