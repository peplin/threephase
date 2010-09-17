require 'spec_helper'

describe TechnicalComponentInstance do
  it { should belong_to :zone }
  it { should belong_to :buildable }

  it { should validate_presence_of :operating }
  it { should validate_presence_of :operating_level }
end
