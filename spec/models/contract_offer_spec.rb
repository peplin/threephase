require 'spec_helper'

describe ContractOffer do
  it { should belong_to :contract_negotiation }
  it { should_not validate_presence_of :accepted }
  it { should validate_presence_of :proposed_amount }
  it { should validate_presence_of :contract_negotiation }
end
