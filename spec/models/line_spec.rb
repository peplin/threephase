require 'spec_helper'

describe Line do
  it { should belong_to :zone }
  it { should belong_to :line_type }
  it { should have_many :repairs }
end
