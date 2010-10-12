require 'spec_helper'

describe Block do
  it { should have_db_index [:x, :y, :map_id] }
  it { should belong_to :map }
  it { should have_many :wind_profiles }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
  it { should validate_presence_of :elevation }
  it { should validate_presence_of :type }
  it { should validate_presence_of :wind_speed }
  it { should validate_presence_of :water_flow }
  it { should validate_presence_of :sunfall }
  it { should validate_presence_of :natural_gas_index }
  it { should validate_presence_of :coal_index }
  it { should validate_presence_of :map }

  context "A Block instance" do
    before do
      @block = Factory :block
    end
    
    it "should have a wind profile for each hour of the day" do
      @block.wind_profiles.count.should eq 24
    end
  end
end
