require 'spec_helper'

describe Block do
  it { should have_db_index [:x, :y, :map_id] }
  it { should belong_to :map }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
  it { should validate_presence_of :elevation }
  it { should validate_presence_of :type }
  it { should validate_presence_of :wind_speed }
  it { should validate_presence_of :water_flow }
  it { should validate_presence_of :sunfall }
  it { should validate_presence_of :natural_gas_index }
  it { should validate_presence_of :coal_index }
end
