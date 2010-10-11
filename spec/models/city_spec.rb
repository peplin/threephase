require 'spec_helper'

describe City do
  it { should belong_to :state }
  it { should have_many :blips }
  it { should have_many :load_profiles }
  it { should have_many :generators }
  it { should have_many :storage_devices }
  it { should have_db_index [:x, :y, :state_id] }

  it { should validate_presence_of :state }

  it { should respond_to :friendly_id }
  it { should respond_to :lines }

  context "A City instance" do
    before do
      @city = Factory :city, :x => 100, :y => 100
      @generator = Factory :generator, :city => @city
    end

    it "should return all repairs" do
      repair = Factory :repair, :repairable => @generator
      @city.repairs.should include repair
    end

    it "should return all bids" do
      bid = Factory :bid, :generator => @generator
      @city.bids.should include bid
    end

    it "should know its current demand" do
      @city.should respond_to(:demand)
    end

    it "should have a positive demand" do
      pending  "not really, but I want to make sure this method is written"
      @city.demand.should be > 0
    end

    it "should have a load profile for each hour of the day" do
      @city.load_profiles.count.should eq 24
    end

    context "with coordinates" do
      it "should know the distance between itself and a set of coordinates" do
        @city.distance(200, 200).should be_close 141.42, 0.5
      end

      it "should know it is right on top of its own cooridnates" do
        @city.distance(100, 100).should be_close 0, 0.5
      end

      it "should know that it is on top of itself" do
        @city.distance_to_city(@city).should be_close 0, 0.5
      end
      
      it "should know the distance between itself an another city" do
        @other = Factory :city, :x => 200, :y => 200
        @city.distance_to_city(@other).should be_close 141.42, 0.5
      end
    end
  end

  context "A new City instance" do
    before do
      @city = City.create! :state => Factory(:state)
    end

    it "should have an x coordinate" do
      @city.x.should be > -1
    end

    it "should have a y coordinate" do
      @city.y.should be > -1
    end
    
    it "should have a name" do
      @city.name.should be_a String
    end
  end
end
