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
        @generator = Factory :generator, :created_at => 2.hours.ago
        stub_time
      end

      it "should return its current revenue"
      it "should return its availability"

      context "in an auction game" do
        before do
          @generator.state.game.regulation_type = :auction
          @generator.save
        end

        it "should return the bid for an arbitrary day" do
          bid = Factory :bid, :generator => @generator,
              :price => @generator.marginal_cost + 2, :created_at => 2.days.ago
          @generator.bid(2.days.ago).should eq(bid.price)
        end

        it "should return the bid for today" do
          bid = Factory :bid, :generator => @generator,
              :price => @generator.marginal_cost + 1
          @generator.bid.should eq(bid.price)
        end

        it "should bid in at marginal cost if there is no bid for a day" do
          @generator.bid.should eq(@generator.marginal_cost)
        end
      end

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

      it "should know how much fuel it has used since a point in time" do
        time = 2.hours.ago
        @generator.stubs(:fuel_burn_rate).returns(1)
        @generator.fuel_used_since(time).should eq(2)
      end

      it "should use more fuel over time" do
        @generator.fuel_used_since(1.hour.ago).should be > (
            @generator.fuel_used_since(10.minutes.ago))
      end

      context "fuel burn rate" do
        it "should have an hourly burn rate" do
          @generator.fuel_burn_rate.should eq(
              @generator.operating_fuel(@generator.operating_level))
        end

        it "should have a level adjusted hourly burn rate" do
        @generator.stubs(:operating_level).returns(@generator.capacity / 2.0)
          @generator.fuel_burn_rate(10.minutes.ago).should eq(
              @generator.operating_fuel(@generator.capacity / 2.0))
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
        @generator = Factory :renewable_generator, :created_at => 2.hours.ago
      end

      it "should not use any fuel" do
        @generator.fuel_used_since(1.hour.ago).should eq 0
      end
    end
  end
end
