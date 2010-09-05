require 'spec_helper'

describe Region do
  it { should belong_to :map }
  it { should belong_to :game }
  it { should validate_presence_of :name }
  it { should validate_presence_of :research_budget }
  it { should allow_value(1000).for(:research_budget) }
  it { should_not allow_value(-1000).for(:research_budget) }
end
