require 'spec_helper'

describe GeneratorType do
  it { should have_one :technical_component }
  it { should have_many :generators }
  it { should belong_to :fuel_type }

  it { should validate_presence_of :safety_mtbf }
  it { should validate_presence_of :safety_incident_severity }
  it { should validate_presence_of :ramping_speed }

  it { should validate_presence_of :fuel_efficiency }
  it { should allow_value(101).for(:fuel_efficiency) }
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
    setup do
      @generator_type = GeneratorType.new
    end

    it "should return its marginal cost" do
    end

    it "should return its current revenue" do
    end

    it "should return its availability" do
    end

    context "with a renewable fuel" do
      setup do
        @generator_type.fuel_type = Fuel.find_by_renewable(true).first
      end

      it "should know its fuel is renewable" do
        assert @generator_type.renewable?
      end

      it "should know it doesn't burn any fuel" do
        assert_equal @generator_type.fuel_amount, 0
      end

      it "should return a marginal cost independent of fuel price" do
        original_mc = @generator_type.marginal_cost
        pending "update market price....of what?"
        assert_equal original_mc, @generator_type.marginal_cost
      end
    end

    context "with a nonrenewable fuel" do
      setup do
        @generator_type.fuel_type = Fuel.find_by_renewable(false).first
      end

      it "should know its fuel is renewable" do
        assert_not @generator_type.renewable?
      end

      it "should return the amount of fuel it burns" do
        assert_equal @generator_type.fuel_amount,
            @generator_type.average_capacity * @generator_type.fuel_efficiency
      end

      it "should return a marginal cost dependent on fuel price" do
        original_mc = @generator_type.marginal_cost
        pending "update market price"
        assert_not_equal original_mc, @generator_type.marginal_cost
      end
    end
  end
end
