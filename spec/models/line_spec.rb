require 'spec_helper'

describe Line do
  it { should belong_to :city }
  it { should belong_to :line_type }

  it { should validate_presence_of :city }
  it { should validate_presence_of :line_type }

  it { should have_many :repairs }
end
