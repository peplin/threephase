require 'spec_helper'

describe Zone do
  it { should belong_to :region }
  it { should have_db_index [:x, :y] }
  it { should validate_presence_of :name }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
end
