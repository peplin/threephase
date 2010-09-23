require 'spec_helper'

describe Repair do
  it { should belong_to :repairable }
  it { should validate_presence_of :repairable }
  it { should validate_presence_of :reason }
  it { should validate_presence_of :cost }
  it { should validate_presence_of :duration }
end
