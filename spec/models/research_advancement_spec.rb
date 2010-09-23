require 'spec_helper'

describe ResearchAdvancement do
  it { should belong_to :region }
  it { should validate_presence_of :region }
  it { should validate_presence_of :reason }
  it { should validate_presence_of :parameter }
  it { should validate_presence_of :adjustment }
end
