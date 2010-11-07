require 'spec_helper'
require 'time'

describe Game do
  it { should have_many :market_prices }
  it { should have_many(:fuel_markets).through(:market_prices) }
  it { should have_many :states }
  it { should have_many(:users).through(:states) }
  it { should have_many(:maps).through(:states) }
  it { should have_many(:generator_types).through(:allowed_generator_types) }

  it { should validate_presence_of :speed}

  it { should_not validate_presence_of :max_players}
  it { should allow_value(3).for(:max_players) }
  it { should_not allow_value(0).for(:max_players) }

  it { should validate_presence_of :max_line_capacity}
  it { should allow_value(300).for(:max_line_capacity) }
  it { should_not allow_value(24).for(:max_line_capacity) }
  it { should_not allow_value(2001).for(:max_line_capacity) }

  it { should validate_presence_of :technology_cost}
  it { should validate_presence_of :technology_reliability}

  it { should validate_presence_of :frequency}
  it { should allow_value(60).for(:frequency) }
  it { should_not allow_value(9).for(:frequency) }
  it { should_not allow_value(121).for(:frequency) }

  it { should validate_presence_of :wind_speed}
  it { should validate_presence_of :sunfall}
  it { should validate_presence_of :water_flow }

  it { should validate_presence_of :regulation_type }
  it { should allow_value(:ror).for(:regulation_type) }

  it { should validate_presence_of :starting_capital }
  it { should allow_value(1000000).for(:starting_capital) }
  it { should_not allow_value(-1).for(:starting_capital) }

  it { should validate_presence_of :interest_rate }

  it { should validate_presence_of :reliability_constraint }
  it { should allow_value(1).for(:reliability_constraint) }
  it { should allow_value(0).for(:reliability_constraint) }
  it { should_not allow_value(-1).for(:reliability_constraint) }

  it { should validate_presence_of :fuel_cost }
  it { should validate_presence_of :fuel_cost_volatility }
  it { should validate_presence_of :workforce_reliability }
  it { should validate_presence_of :workforce_cost }
  it { should validate_presence_of :unionized }
  it { should validate_presence_of :carbon_allowance }
  it { should validate_presence_of :tax_credit }
  it { should validate_presence_of :renewable_requirement }
  it { should validate_presence_of :political_stability }
  it { should validate_presence_of :political_opposition }
  it { should validate_presence_of :public_support }

  context "A Game instance" do
    before do
      @fuel_market = Factory :fuel_market
      @game = Factory :game
    end

    it "should have initialized market prices" do
      FuelMarket.all.each do |fuel_market|
        fuel_market.market_prices.length.should be > 0
        fuel_market.market_prices.find_all_by_game_id(@game).count.should eq(1)
      end
    end

    it "should know the current market price" do
      (@game.current_price(@fuel_market)).should eq(
          @fuel_market.current_price(@game))
    end

    it "should be able to step"

    context "with a scaled time" do
      it "should have the same speed as the game" do
        @game.time.speed.should eq(@game.speed)
      end
    end

    it "should return all generators" do
      generators = @game.states.collect(&:generators).flatten
      @game.generators.should eq(generators)
    end

    it "should return all generators using a specific fuel" do
      fuel_market = Factory :fuel_market
      generators = @game.states.collect do |state|
        state.generators(fuel_market)
      end.flatten
      @game.generators.should eq(generators)
    end

    context "A game time instance" do
      before do
        stub_time
        @game = Factory :game, :speed => 1, :created_at => 2.hours.ago
      end

      context "with real-time speed" do
        it "should return a non-scaled game time" do
          @game.time.at(1.hour.ago).to_i.should be_close(1.hour.ago.to_i, 1)
          @game.time.now.to_i.should eq(Time.now.to_i)
        end

        it "should convert an integer to Time" do
          time = Time.now
          # Could be ~1 off due to int truncation issues, but that's just an
          # issue with the test.
          @game.time.at(time.to_i).to_i.should be_close(
              @game.time.at(time).to_i, 1.1)
          @game.time.at(time.to_i).to_i.should be_close(
              Time.at(time.to_i).to_i, 1.1)
        end
      end

      context "with a scaled speed" do
        before do
          @game = Factory :game, :speed => 10, :created_at => 10.minutes.ago
          @time = @game.time
        end

        it "should scale time passed based on game speed" do
          @time.now.should eq(90.minutes.from_now)
        end

        it "should return a time scaled to game time" do
          @time.now.should eq(@time.at(Time.now))
        end

        it "should convert Time to GameTime before subtracting" do
          (@time.now - Time.now).to_i.should eq(0)
        end

        it "should not convert GameTime to GameTime before subtracting" do
          (@time.at(10.minutes.from_now) - @time.now).should eq(100.minutes)
        end

        it "should convert an integer to Time" do
          time = Time.now
          # Again, due to some conversions this will be close but probably off
          # by a few seconds. If there was a real error, it would be off by more
          # than that, since the time speed is 10.
          @time.at(time.to_i).to_i.should be_close(@time.at(time).to_i, 10)
        end

        it "should de-scale a game time to normal" do
          time = Time.now
          @time.to_normal(@time.at(time)).should eq(time)
        end
      end
    end
  end
end
