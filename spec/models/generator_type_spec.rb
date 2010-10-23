require 'spec_helper'

describe GeneratorType do
  it { should have_one :technical_component }
  it { should have_many :generators }
  it { should belong_to :fuel_type }

  it { should validate_presence_of :fuel_type }

  it { should validate_presence_of :safety_mtbf }
  it { should validate_presence_of :safety_incident_severity }
  it { should validate_presence_of :ramping_speed }

  it { should validate_presence_of :fuel_efficiency }
  it { should_not allow_value(101).for(:fuel_efficiency) }
  it { should_not allow_value(-1).for(:fuel_efficiency) }

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

    it "should have a marginal cost dependent on operating level" do
      @generator_type.marginal_cost(@city, 15).should be < (
          @generator_type.marginal_cost(@city))
    end

    context "with a renewable fuel" do
      before do
        @generator_type.fuel_type = Factory :fuel_type, :renewable => true
      end

      it "should know its fuel is renewable" do
        @generator_type.renewable?.should eq true
      end

      it "should know it doesn't burn any fuel" do
        @generator_type.marginal_fuel.should eq(0)
      end
    end

    context "with a nonrenewable fuel" do
      before do
        @generator_type.fuel_type = Factory :fuel_type, :renewable => false
      end

      it "should know its fuel is renewable" do
        @generator_type.renewable?.should be(false)
      end

      it "should return the amount of fuel it burns" do
        @generator_type.marginal_fuel.should eq(
            @generator_type.average_capacity * @generator_type.fuel_efficiency)
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
