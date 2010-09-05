require 'spec_helper'

describe ContractNegotiation do
  it { should belong_to :generator }
  it { should have_many :contract_offers }
  it { should validate_presence_of :reason }
  it { should validate_presence_of :amount }
  it { should validate_presence_of :offline }
end
