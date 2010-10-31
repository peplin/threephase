require 'spec_helper'

describe City do
  it { should belong_to :state }
  it { should have_many :generators }
  it { should have_many :storage_devices }
  it { should have_many(:bids).through(:generators) }
  it { should have_db_index [:x, :y, :state_id] }

  it { should validate_presence_of :state }
  it { should_not allow_value(-1).for(:customers) }

  it { should respond_to :friendly_id }
  it { should respond_to :lines }

  context "A City instance" do
    before do
      @city = Factory :city, :x => 100, :y => 100
      @generator = Factory :generator, :city => @city
    end

    it "should have a map shortcut" do
      @city.map.should eq(@city.state.map)
    end

    it "should have a shortcut to its game" do
      @city.game.should eq(@city.state.game)
    end

    it "should return all repairs" do
      repair = Factory :repair, :repairable => @generator
      @city.repairs.should include repair
    end

    it "should return all bids" do
      bid = Factory :bid
      bid.generator.city = @city
      bid.generator.save
      @city.reload
      @city.bids.should include bid
    end

    it "should know its current demand" do
      @city.should respond_to(:demand)
    end

    it "should have a positive demand" do
      @city.demand.should be > 0
    end

    it "should have a peak demand" do
      @city.peak_demand.should eq(@city.load_profile.max)
    end

    it "should vary demand based on number of customers" do
      time = Time.now.beginning_of_day
      original_demand = @city.demand(time)
      @city.customers *= 2
      @city.demand(time).should be > original_demand
    end

    it "should have a load profile for each hour of the day" do
      @city.load_profile.length.should eq 24
    end

    it "should have higher load if during the day" do
      @city.demand(Time.now.beginning_of_day + 13.hours
          ).should be > @city.demand(Time.now.beginning_of_day + 3.hours)
    end

    it "should know the amount of power demanded since a time" do
      time = 6.hours.ago
      @city.stubs(:demand).returns(1)
      @city.demanded_since(time).should eq(
          (time.to_i..Time.now.utc.to_i).step(1.hour).length)
    end

    it "should know the current local price" do
      fuel_market = Factory :fuel_market
      @city.current_price(fuel_market).should eq(
          fuel_market.current_local_price(@city))
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

    context "with a map" do
      it "should scale resource indicies by customers" do
        bigger_city = Factory :city, :customers => @city.customers * 2
        bigger_city.coal_index.should be > @city.coal_index
      end

      context "with some coal" do
        before do
          @city.map.blocks.first.coal_index = 42
        end

        it "should have a coal index cached from the map" do
          @city.coal_index.should be >= 0
        end
      end

      context "with some oil" do
        before do
          @city.map.blocks.first.oil_index = 42
        end

        it "should have a oil index cached from the map" do 
          @city.oil_index.should be >= 0
        end
      end

      context "with some gas" do
        before do
          @city.map.blocks.first.natural_gas_index = 42
        end

        it "should have a natural gas index cached from the map" do
          @city.natural_gas_index.should be >= 0
        end
      end

      context "with some sun" do
        before do
          @city.map.blocks.first.sun_index = 42
        end

        it "should have annual sunfall cached from the map" do
          @city.sun_index.should be >= 0
        end
      end

      context "with some wind" do
        before do
          @city.map.blocks.first.wind_index = 42
        end

        it "should have average windspeed cached from the map" do
          @city.wind_index.should be >= 0
        end
      end

      context "with some water" do
        before do
          @city.map.blocks.first.water_index = 42
        end

        it "should have average water flow from the map" do
          @city.water_index.should be >= 0
        end
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
