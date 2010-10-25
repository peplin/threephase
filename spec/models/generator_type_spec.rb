require 'spec_helper'

describe GeneratorType do
  it { should have_one :technical_component }
  it { should have_many :generators }
  it { should belong_to :fuel_type }

  it { should validate_presence_of :fuel_type }

  it { should validate_presence_of :safety_mtbf }
  it { should validate_presence_of :safety_incident_severity }

  it { should validate_presence_of :ramping_speed }
  it { should allow_value(0).for(:ramping_speed) }
  it { should_not allow_value(-1).for(:ramping_speed) }

  it { should validate_presence_of :marginal_fuel_burn_rate }
  it { should allow_value(0).for(:marginal_fuel_burn_rate) }
  it { should_not allow_value(-1).for(:marginal_fuel_burn_rate) }

  it { should validate_presence_of :air_emissions }
  it { should_not allow_value(-1).for(:air_emissions) }

  it { should validate_presence_of :water_emissions }
  it { should_not allow_value(-1).for(:water_emissions) }

  it { should validate_presence_of :maintenance_cost_min }
  it { should_not allow_value(-1).for(:maintenance_cost_min) }

  it { should validate_presence_of :maintenance_cost_max }
  it { should_not allow_value(0).for(:maintenance_cost_max) }

  it { should validate_presence_of :tax_credit }
  it { should_not allow_value(-1).for(:tax_credit) }

  context "A GeneratorType instance" do
    before do
      @generator_type = Factory :generator_type
      @game = Factory :game
      @state = Factory :state, :game => @game
      @city = Factory :city, :state => @state
    end

    it "should return its marginal cost" do
      @generator_type.marginal_cost(@city).should be > 0
    end

    it "should have a operating cost" do
      @generator_type.operating_cost(@city, 15).should be < (
          @generator_type.operating_cost(@city))
    end

    context "with a renewable fuel" do
      before do
        @generator_type.marginal_fuel_burn_rate = 0
      end

      it "should know its fuel is renewable" do
        @generator_type.renewable?.should eq true
      end

      it "should know it doesn't burn any fuel" do
        @generator_type.marginal_fuel.should eq(0)
      end
    end

    context "with a nonrenewable fuel" do
      it "should know its fuel is renewable" do
        @generator_type.renewable?.should be(false)
      end

      it "should return the amount of fuel it burns" do
        @generator_type.marginal_fuel.should eq(
            @generator_type.capacity * @generator_type.marginal_fuel_burn_rate)
      end

      it "should return a marginal cost dependent on fuel price" do
        original_mc = @generator_type.marginal_cost(@city)
        @generator_type.fuel_type.market.market_prices.create(:price => 42,
            :game => @game)
        assert_not_equal original_mc, @generator_type.marginal_cost(@city)
      end
    end
  end
end
