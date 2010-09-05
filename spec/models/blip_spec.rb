require 'spec_helper'

describe Blip do
  it { should have_db_index [:x, :y, :zone_id] }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
  it { should validate_presence_of :power_factor }
  it { should belong_to :zone }
end
