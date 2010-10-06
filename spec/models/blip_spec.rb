require 'spec_helper'

describe Blip do
  it { should have_db_index [:x, :y, :city_id] }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
  it { should validate_presence_of :power_factor }
  it { should validate_presence_of :city }
  it { should belong_to :city }
end
