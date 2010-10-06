require 'spec_helper'

describe TechnicalComponentInstance do
  it { should belong_to :city }
  it { should belong_to :buildable }

  it { should validate_presence_of :city }
  it { should validate_presence_of :operating_level }
end
