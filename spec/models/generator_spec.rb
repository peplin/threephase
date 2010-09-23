require 'spec_helper'

describe Generator do
  it { should belong_to :zone }
  it { should belong_to :generator_type }
  it { should have_many :contract_negotiations }
  it { should have_many(:contract_offers).through(:contract_negotiations) }
  it { should have_many :bids }
  it { should have_many :repairs }
  it { should validate_presence_of :zone }
  it { should validate_presence_of :generator_type }
end
