require 'spec_helper'

describe Block do
  it { should have_db_index [:x, :y, :map_id] }
  it { should belong_to :map }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
  it { should validate_presence_of :elevation }
  it { should validate_presence_of :block_type }
  it { should validate_presence_of :wind_index }
  it { should validate_presence_of :water_index }
  it { should validate_presence_of :sun_index }
  it { should validate_presence_of :natural_gas_index }
  it { should validate_presence_of :coal_index }
  it { should validate_presence_of :oil_index }
  it { should validate_presence_of :map }

  context "A Block instance" do
    before do
      @block = Factory :block
    end

    it "should have a static wind profile"
  end
end
