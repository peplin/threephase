require 'spec_helper'

describe Bid do
  it { should validate_presence_of :price }
  it { should_not validate_presence_of :accepted }
  it { should belong_to :generator }
end
