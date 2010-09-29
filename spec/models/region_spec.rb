require 'spec_helper'

describe Region do
  it { should belong_to :map }
  it { should belong_to :game }
  it { should belong_to :user }
  it { should validate_presence_of :map }
  it { should validate_presence_of :game }
  it { should validate_presence_of :user }
  it { should have_many :research_advancements }
  it { should have_many :incoming_interstate_lines }
  it { should have_many :outgoing_interstate_lines }
  it { should validate_presence_of :name }
  it { should validate_presence_of :research_budget }
  it { should allow_value(1000).for(:research_budget) }
  it { should_not allow_value(-1000).for(:research_budget) }

  context "with an instance of Region" do
    before :all do
      @region = Factory :region
      @zone = Factory :zone, :region => @region
      @generator = Factory :generator, :zone => @zone
    end

    it "should return all repairs" do
      repair = Factory :repair, :repairable => @generator
      @region.repairs.should include repair
    end

    it "should return all bids" do
      bid = Factory :bid, :generator => @generator
      @region.bids.should include bid
    end

    it "should return all contracts" do
      contract = Factory :contract, :generator => @generator
      @region.contracts.should include contract
    end

    it "should return free coordinates" do
      x, y = @region.next_free_coordinates
      x.should be > -1
      y.should be > -1
      @region.zones.each do |zone|
        next if zone == @zone or not zone.valid?
        zone.distance(x, y).should be > Region::ZONE_BUFFER
      end
    end

    it "should return the nearest zone to a pair of coordinates" do
      @region.zones.find_nearest(100, 200)
    end

  end

  context "when a Region is created" do
    before :all do
      @region = Factory :region
    end

    it "should create a few zones" do
      @region.zones.count.should be > 0
    end
  end
end
