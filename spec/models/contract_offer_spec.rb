require 'spec_helper'

describe Offer do
  it { should belong_to :contract }
  it { should_not validate_presence_of :accepted }
  it { should validate_presence_of :proposed_amount }
  it { should validate_presence_of :contract }
end
