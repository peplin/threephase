require 'spec_helper'

describe Map do
  it { should belong_to :user }
  it { should have_many :states }
  it { should have_many :blocks }
  it { should allow_value("Cityville").for(:name) }
  it { should_not allow_value("foobarfoobarfoobarfoobarfoobarfoobarfoobarfoobar"
      ).for(:name) }

  it { should respond_to :friendly_id }

  context "A Map instance" do
    before do
      @map = Factory :map
    end

    it "should have a height" do 
      @map.height.should be >= 0
    end

    it "should have a width" do
      @map.width.should be >= 0
    end

    it "should have initialized blocks" do
      @map.blocks.length.should be > 0
    end

    it "should return blocks within a certain distance of some coordinates" do
      radius, x, y = 100, 42, 42
      blocks = @map.blocks.collect {|block|
        block if block.distance(x, y) < radius
      }.compact
      @map.blocks.near(x, y, radius).should eq(blocks)
    end

    context "with natural resource helpers" do
      it "should calculate an overall natural resource index" do
        blocks = @map.blocks
        index = blocks.inject(0) {|total, block|
          total + block.natural_resource_index(:coal)
        }
        @map.natural_resource_index(:coal).should eq(index)
      end

      it "should calculate a natural resource index over a radius at a point" do
        radius, x, y = 100, 42, 42
        blocks = @map.blocks.near(x, y, radius)
        index = blocks.inject(0) {|total, block|
          total + block.natural_resource_index(:coal)
        }
        @map.natural_resource_index(:coal, x, y, radius).should eq(index)
      end
    end
  end
end
