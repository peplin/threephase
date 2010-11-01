require 'spec_helper'

describe MarginalPrice do
  it { should belong_to :state }
  it { should validate_presence_of :marginal_price }
  it { should validate_presence_of :state }
end
