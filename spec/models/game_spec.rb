require 'spec_helper'
require 'time'

describe Game do
  it { should have_many :market_prices }
  it { should have_many(:markets).through(:market_prices) }
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
  it { should validate_presence_of :power_factor}

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

  it "should have a base time scale factor" do
    assert Game::TIME_SCALE_FACTOR
  end

  context "A Game instance" do
    before do
      @game = Factory :game
      @market = Factory :market
    end

    it "should have initialized market prices" do
      Market.all.each do |market|
        market.market_prices.length.should be > 0
        market.market_prices.find_by_game_id(@game).count.should eq(1)
      end
    end

    it "should know the current market price" do
      (@game.current_price @market).should eq(@market.current_price @game)
    end

    context "that has been updated" do
      before do
        @game.updated_at = Time.now - 60
        @now = Time.now
        Time.stubs(:now).returns(@now)
      end

      it "should scale time passed based on game speed" do
        @game.speed = 0
        real_time = @game.time_since_update
        @game.speed = 1
        fast_time = @game.time_since_update
        real_time.should be > (@now - @game.updated_at)
        fast_time.should be > (@now - @game.updated_at)
        real_time.should be < fast_time
      end

      it "should know how much time has passed with maxiumum speed" do
        @game.speed = 1
        @game.time_since_update.should be > (@now - @game.updated_at)
      end
    end
  end
end
