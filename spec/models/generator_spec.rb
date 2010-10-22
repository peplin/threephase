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
      end

      it "should return its current revenue"
      it "should return its availability"

      context "when the simulation is stepped" do
        it "should deduct the marginal cost for that time from the state" do
          original_cash = @generator.state.cash
          @generator.step 1.hour.ago
          @generator.state.cash.should eq(original_cash -
              @generator.cost_since(1.hour.ago))
        end
      end

      it "should know how much fuel it has used since a point in time" do
        @generator.fuel_used_since(2.hour.ago).should be_close(
            @generator.operating_level *
              @generator.generator_type.fuel_efficiency * 2, 1)
      end

      it "should use more fuel over time" do
        @generator.fuel_used_since(1.hour.ago).should be > (
            @generator.fuel_used_since(10.minutes.ago))
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
