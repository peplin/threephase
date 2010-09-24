require 'spec_helper'

describe Region do
  it { should belong_to :map }
  it { should belong_to :game }
  it { should belong_to :user }
  it { should validate_presence_of :map }
  it { should validate_presence_of :game }
  it { should validate_presence_of :user }
  it { should have_many :research_advancements }
  it { should have_many :incoming_interstate_lines }
  it { should have_many :outgoing_interstate_lines }
  it { should validate_presence_of :name }
  it { should validate_presence_of :research_budget }
  it { should allow_value(1000).for(:research_budget) }
  it { should_not allow_value(-1000).for(:research_budget) }

  it { should respond_to :friendly_id }
end
