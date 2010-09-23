class ContractOffer < ActiveRecord::Base
  belongs_to :contract_negotiation

  validates_presence_of :proposed_amount
  validates :contract_negotiation, :presence => true
end
