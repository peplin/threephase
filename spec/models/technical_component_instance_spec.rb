require 'spec_helper'

describe TechnicalComponentInstance do
  it { should belong_to :zone }
  it { should belong_to :buildable }
end
