class ContractNegotiation < ActiveRecord::Base
  belongs_to :generator
  has_many :contract_offers
  validates_presence_of :reason
  validates_presence_of :amount
  validates_presence_of :offline
end
