require 'spec_helper'

describe Generator do
  it { should belong_to :city }
  it { should belong_to :generator_type }
  it { should have_many :contracts }
  it { should have_many(:offers).through(:contracts) }
  it { should have_many :bids }
  it { should have_many :repairs }
  it { should validate_presence_of :city }
  it { should validate_presence_of :generator_type }
end
