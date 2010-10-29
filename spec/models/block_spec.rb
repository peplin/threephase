require 'spec_helper'

describe Block do
  it { should have_db_index [:x, :y, :map_id] }
  it { should belong_to :map }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
  it { should validate_presence_of :elevation }
  it { should validate_presence_of :block_type }
  it { should validate_presence_of :map }

  context "A Block instance" do
    before do
      @block = Factory :block
    end

    it "should have a static wind profile"

    it "should know the distance between itself and something else" do
      other_x, other_y = @block.x + 12, @block.y + 55
      @block.distance(other_x, other_y).should eq(
          @block.coordinate_distance(@block.x, @block.y, other_x, other_y))
    end

    it "should have a natural resource index helper" do
      @block.natural_resource_index(:coal).should eq(@block.coal_index)
    end

    it "should set values for resource indicides" do
      [:coal_index, :oil_index, :natural_gas_index, :sun_index, :wind_index,
          :water_index].each do |index|
        @block.send(index).should be >= 0
      end
    end
  end
end
