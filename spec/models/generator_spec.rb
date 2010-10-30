require 'spec_helper'

describe Generator do
  it { should belong_to :city }
  it { should belong_to :generator_type }
  it { should have_many :bids }
  it { should have_many :repairs }
  it { should validate_presence_of :city }
  it { should validate_presence_of :generator_type }

  context "an instance of Generator" do
    context "with non-renewable fuel" do
      before do
        @generator = Factory :generator
        stub_time
      end

      it "should return its current revenue"
      it "should return its availability"

      it "should have a marginal cost shortcut" do
        @generator.marginal_cost.should eq(
            @generator.generator_type.marginal_cost(@generator.city))
      end

      it "should have a capacity shortcut" do
        @generator.capacity.should eq(@generator.generator_type.capacity)
      end
      
      it "should have a marginal fuel cost shortcut" do
        @generator.marginal_fuel_cost.should eq(
            @generator.generator_type.marginal_fuel_cost(@generator.city))
      end

      context "when the simulation is stepped" do
        before do
          cost = @generator.cost_since(1.hour.ago)
          Generator.any_instance.stubs(:cost_since).returns(cost)
        end

        it "should deduct the marginal cost for that time from the state" do
          original_cash = @generator.state.cash
          @generator.step 1.hour.ago
          @generator.state.cash.should be_close(original_cash -
              @generator.cost_since(1.hour.ago), 1)
        end
      end

      it "should know how much fuel it has used since a point in time" do
        time = 2.hours.ago
        debugger # TODO
        @generator.fuel_used_since(time).should eq(
            @generator.generator_type.operating_fuel(
              @generator.operating_level) * @generator.operated_hours(time))
      end

      it "should use more fuel over time" do
        @generator.fuel_used_since(1.hour.ago).should be > (
            @generator.fuel_used_since(10.minutes.ago))
      end

      it "should allow an override of operating level when calculating fuel" do
        time = 1.hour.ago
        @generator.fuel_used_since(time, 100).should be > (
            @generator.fuel_used_since(time, 50))
      end

      context "fuel burn rate" do
        it "should have an hourly burn rate" do
          @generator.fuel_burn_rate.should eq(
              @generator.generator_type.operating_fuel(@generator.city))
        end

        it "should have a level adjusted hourly burn rate" do
          @generator.fuel_burn_rate(50).should eq(
              @generator.generator_type.operating_fuel(@generator.city, 50))
        end

        it "should have an average fuel burn rate for the day" do
          @generator.average_fuel_burn_rate.should eq(
              @generator.fuel_burn_rate(@generator.average_operating_level))
        end

        it "should have an average fuel burn rate for an arbitrary day" do
          day = 1.day.ago
          @generator.average_fuel_burn_rate(day).should eq(
              @generator.fuel_burn_rate(
              @generator.average_operating_level(day)))
        end

        it "should have an average fuel burn dependent only on day, not time" do
          @generator.average_fuel_burn_rate(
              Time.now.at_beginning_of_day).should eq(
              @generator.average_fuel_burn_rate(Time.now.end_of_day))
        end
      end
    end

    context "with renewable fuel" do
      before do
        @generator = Factory :renewable_generator
      end

      it "should not use any fuel" do
        @generator.fuel_used_since(1.hour.ago).should eq 0
      end
    end
  end
end
