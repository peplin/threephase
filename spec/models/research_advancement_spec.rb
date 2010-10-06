require 'spec_helper'

describe ResearchAdvancement do
  it { should belong_to :state }
  it { should validate_presence_of :state }
  it { should validate_presence_of :reason }
  it { should validate_presence_of :parameter }
  it { should validate_presence_of :adjustment }
end
