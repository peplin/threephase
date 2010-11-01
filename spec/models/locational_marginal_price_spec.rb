require 'spec_helper'

describe LocationalMarginalPrice do
  it { should belong_to :city }
  it { should validate_presence_of :marginal_price }
  it { should validate_presence_of :city }
end
