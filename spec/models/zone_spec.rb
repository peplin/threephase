require 'spec_helper'

describe Zone do
  it { should belong_to :state }
  it { should have_many :blips }
  it { should have_many :load_profiles }
  it { should have_many :generators }
  it { should have_many :lines }
  it { should have_many :storage_devices }
  it { should have_db_index [:x, :y, :state_id] }

  it { should validate_presence_of :state }

  it { should respond_to :friendly_id }

  context "A Zone instance" do
    before do
      @zone = Factory :zone, :x => 100, :y => 100
      @generator = Factory :generator, :zone => @zone
    end

    it "should return all repairs" do
      repair = Factory :repair, :repairable => @generator
      @zone.repairs.should include repair
    end

    it "should return all bids" do
      bid = Factory :bid, :generator => @generator
      @zone.bids.should include bid
    end

    it "should return all contracts" do
      contract = Factory :contract, :generator => @generator
      @zone.contracts.should include contract
    end

    it "should know its current demand" do
      @zone.should respond_to(:demand)
    end

    it "should have a positive demand" do
      pending  "not really, but I want to make sure this method is written"
      @zone.demand.should be > 0
    end

    it "should have a load profile for each hour of the day" do
      @zone.load_profiles.count.should eq 24
    end

    context "with coordinates" do
      it "should know the distance between itself and a set of coordinates" do
        @zone.distance(200, 200).should be_close 141.42, 0.5
      end

      it "should know it is right on top of its own cooridnates" do
        @zone.distance(100, 100).should be_close 0, 0.5
      end

      it "should know that it is on top of itself" do
        @zone.distance_to_zone(@zone).should be_close 0, 0.5
      end
      
      it "should know the distance between itself an another zone" do
        @other = Factory :zone, :x => 200, :y => 200
        @zone.distance_to_zone(@other).should be_close 141.42, 0.5
      end
    end
  end

  context "A new Zone instance" do
    before do
      @zone = Zone.create! :state => Factory(:state)
    end

    it "should have an x coordinate" do
      @zone.x.should be > -1
    end

    it "should have a y coordinate" do
      @zone.y.should be > -1
    end
    
    it "should have a name" do
      @zone.name.should be_a String
    end
  end
end
