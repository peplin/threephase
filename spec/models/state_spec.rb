require 'spec_helper'

describe State do
  it { should belong_to :map }
  it { should belong_to :game }
  it { should belong_to :user }
  it { should validate_presence_of :map }
  it { should validate_presence_of :game }
  it { should validate_presence_of :user }
  it { should have_many :research_advancements }
  it { should have_many :incoming_interstate_lines }
  it { should have_many :outgoing_interstate_lines }
  it { should have_many(:generators).through(:cities) }
  it { should have_many(:storage_devices).through(:cities) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :research_budget }
  it { should allow_value(1000).for(:research_budget) }
  it { should_not allow_value(-1000).for(:research_budget) }
  it { should allow_value(1000).for(:research_budget) }
  it { should_not allow_value(-1).for(:cash) }

  context "with an instance of State" do
    before :all do
      @state = Factory :state
      @city = Factory :city, :state => @state
      @generator = Factory :generator, :city => @city
      @generator.fuel_market.initialize_for @state.game
      @line = Factory :line, :city => @city
      @storage_device = Factory :storage_device, :city => @city
    end

    it "should return the map's natural resource index" do
      @state.natural_resource_index(:coal).should eq(
        @state.map.natural_resource_index(:coal))
    end

    it "should return all repairs" do
      repair = Factory :repair, :repairable => @generator
      @state.repairs.should include repair
    end

    it "should return all bids" do
      bid = Factory :bid
      bid.generator.city = @city
      bid.generator.save
      @state.reload
      @state.bids.should include bid
    end

    context "with another renewable generator" do
      before do
        @another_generator = Factory :renewable_generator, :city => @city
      end

      it "should have a fuel type finder on generators" do
        @state.generators.find_by_fuel_market(
            @generator.fuel_market).should include @generator
        @state.generators.find_by_fuel_market(
            @generator.fuel_market).should_not include @another_generator
        @state.generators.find_by_fuel_market(
            @another_generator.fuel_market).should include @another_generator
      end

      it "should order generators by marginal cost" do
        @state.generators.ordered_by_marginal_cost.first.should eq(
            @another_generator)
      end

      it "should only include generators that existed in ordered list" do
        @state.generators.ordered_by_marginal_cost(1.day.ago).first.should eq(
          nil)
      end
    end

    it "should return all lines" do
      @state.lines.should include @line
    end

    it "should generate starting cash" do 
      @state.cash.should eq(@state.game.starting_capital)
    end

    it "should expose a total generation capacity" do
      capacity = @state.generators.inject(0) {|generation, generator|
        generation + generator.capacity
      }
      @state.capacity.should eq(capacity)
    end
    
    it "should have demand equal to the sum of the demand of the cities" do
      @state.demand.should eq(@state.cities.inject(0) {|demand, city|
        demand + city.demand
      })
    end

    it "should have demand at a certain time of its cities" do
      time = Time.now
      @state.demand(time).should eq(@state.cities.inject(0) {|demand, city|
        demand + city.demand(time)
      })
    end

    it "should have peak demand equal to sum of the peak demand of cities" do
      @state.peak_demand.should eq(@state.cities.inject(0) {|demand, city|
        demand + city.peak_demand
      })
    end

    it "should set all generator operating levels based on the MC curve" do
      another_generator = Factory :generator, :city => @city
      another_generator.fuel_market.initialize_for @state.game
      ordered_generators = @state.generators.ordered_by_marginal_cost
      @state.stubs(:demand).returns(@generator.capacity - 1)
      @state.optimal_operating_level(ordered_generators[0]).should be < (
          ordered_generators[0].capacity)
      @state.optimal_operating_level(ordered_generators[1]).should eq(0)

      @state.stubs(:demand).returns(@generator.capacity)
      @state.optimal_operating_level(ordered_generators[0]).should eq(
          ordered_generators[0].capacity)
      @state.optimal_operating_level(ordered_generators[1]).should eq(0)

      @state.stubs(:demand).returns(@generator.capacity + 10)
      @state.optimal_operating_level(ordered_generators[0]).should eq(
          ordered_generators[0].capacity)
      @state.optimal_operating_level(ordered_generators[1]).should be > 0

      @state.stubs(:demand).returns(
          @generator.capacity + another_generator.capacity + 2)
      @state.optimal_operating_level(ordered_generators[0]).should eq(
          ordered_generators[0].capacity)
      @state.optimal_operating_level(ordered_generators[1]).should eq(
          ordered_generators[1].capacity)
    end

    it "should return free coordinates" do
      x, y = @state.next_free_coordinates
      x.should be > -1
      y.should be > -1
      @state.cities.each do |city|
        next if city == @city or not city.valid?
        city.distance(x, y).should be > State::CITY_BUFFER
      end
    end

    it "should return the nearest city to a pair of coordinates" do
      @state.cities.find_nearest(100, 200)
    end

    it "should return the marginal cost to customers" do
      mc = 0
      @state.generators.ordered_by_marginal_cost.inject(0) do |level, gen|
        capacity_shortfall = @state.demand - level
        met_capacity = [gen.capacity, capacity_shortfall].min
        level += met_capacity
        if capacity_shortfall - level <= 0 or not @state.demand_met?
          mc = gen.marginal_cost
          break
        end
      end
      @state.marginal_cost_to_customers.should be > 0
      @state.marginal_cost_to_customers.should eq(mc)
    end

    it "should charge customers the MC * demand over time" do
      time = 1.hour.ago
      @state.customers_charged_at = time
      # TODO this is slightly problematic if the difference in time between
      # charging customers crosses the day boundary. we are using the
      # marginal_cost_to_consumers for TODAY, so it would calculate the wrong
      # total. let's not worry about it for the first release.
      proc { @state.charge_customers }.should change(@state, :cash).by(
          (@state.marginal_cost_to_customers *
            @state.demanded_since(time)).ceil)
    end

    it "should deduct operating costs" do
      operating_costs = -1
      # TODO
      proc { @state.deduct_operating_costs }.should change(@state, :cash).by(
          operating_costs)
    end

    it "should know the amount of power demanded since a time" do
      time = 6.hours.ago
      @state.demanded_since(time).should eq(
        @state.cities.inject(0) do |demanded, city|
          city.demanded_since(time)
        end)
    end

    it "should know if demand is met" do
      @state.stubs(:demand).returns(100)
      @state.demand_met?.should eq(true)
      @state.stubs(:demand).returns(300)
      @state.demand_met?.should eq(false)
    end

    it "should be able to step"
  end

  context "when a State is created" do
    before :all do
      @state = Factory :state
    end

    it "should create a few cities" do
      @state.cities.count.should be > 0
    end
  end
end
