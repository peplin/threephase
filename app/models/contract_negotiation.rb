class ContractNegotiation < ActiveRecord::Base
  belongs_to :generator
  has_many :contract_offers

  validates :reason, :presence => true
  validates :amount, :presence => true
  validates :generator, :presence => true
end
