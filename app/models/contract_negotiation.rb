class ContractNegotiation < ActiveRecord::Base
  belongs_to :generator
  has_many :contract_offers
end
