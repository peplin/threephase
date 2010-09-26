require 'spec_helper'

describe Contract do
  it { should belong_to :generator }
  it { should have_many :offers }
  it { should validate_presence_of :reason }
  it { should validate_presence_of :amount }
  it { should validate_presence_of :generator }
end
