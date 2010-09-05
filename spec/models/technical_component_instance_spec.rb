require 'spec_helper'

describe TechnicalComponentInstance do
  it { should belong_to :zone }
  it { should belong_to :buildable }
  it { should validate_presence_of :buildable_type }
  it { should validate_presence_of :instance_type }
end
