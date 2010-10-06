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

  it { should validate_presence_of :max_players}
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

    it "should know the current market price" do
      (@game.current_price @market).should eq(@market.current_price @game)
    end

    context "should know how much game-relative time has passed" do
      before do
        @game.updated_at = Time.parse("1 minute ago")
        @now = Time.now
      end

      it "with a real-time speed" do
        @game.speed = 0
        assert_equal @game.time_since(@now), @now - @game.updated_at
      end

      it "with maxiumum speed" do
        @game.speed = 1
        assert_equal @game.time_since(@now),
            Game::TIME_SCALE_FACTOR * (@now - @game.updated_at)
      end
    end
  end
end
