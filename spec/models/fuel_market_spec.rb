require 'spec_helper'

describe FuelMarket do
  it { should have_many :market_prices }
  it { should have_many(:games).through(:market_prices) }
  it { should have_many :generator_types }
  it { should have_many(:generators).through(:generator_types) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :initial_average_price }
  it { should validate_presence_of :initial_standard_deviation }
  it { should validate_presence_of :supply_slope }

  it { should respond_to :friendly_id }

  it "should initialize for a game based on average price and std. dev." do
    market = Factory :fuel_market
    game = Factory :game
    proc { market.initialize_for(game) }.should change(
        MarketPrice, :count).by(1)
    price = market.market_prices.find_by_game_id(game)
    price.price.should be >= market.initial_average_price - market.initial_standard_deviation
    price.price.should be <= market.initial_average_price + market.initial_standard_deviation
  end

  context "A FuelMarket instance" do
    before do
      @price = Factory :market_price
      @market = @price.fuel_market
      @game = @price.game
      @state = Factory :state, :game => @game
      @city = Factory :city, :state => @state, :customers => 100000
      @generator_type = Factory :generator_type, :fuel_market => @market
      @generator = Factory :generator, :city => @city,
          :generator_type => @generator_type
      @another_price = Factory :market_price
      @another_game = @another_price.game
      @another_state = Factory :another_state, :game => @another_game
      @another_city = Factory :another_city, :state => @another_state
    end

    context "with stubbed time" do
      before do
        stub_time
      end

      it "should know the instantaneous demand in a game" do
        demand = @game.generators(@market).inject(0) {|demand, gen|
          demand + gen.fuel_burn_rate
        }
        @market.demand(@game).should eq(demand)
      end

      it "should know the average demand for the fuel now in a game" do
        average = @game.generators(@market).inject(0) {|demand, gen|
          demand + gen.average_fuel_burn_rate
        }
        @market.average_demand(@game).should eq(average)
      end

      it "should have a current price for the overall market in a game" do
        (@market.current_price(@game)).should eq(
            @game.market_prices.find_by_fuel_market_id(@market,
                :order => "created_at DESC").price)
      end

      it "should have a current/timed price helper" do
        @market.price(@game).should eq(@market.current_price(@game))
        @market.price(@game, Time.now).should eq(
            @market.price_at(@game, Time.now))
      end

      it "should return the price discount for a city" do
        @market.discount_for(@city).should eq(
            @city.natural_resource_index(@market.related_natural_resource) /
              @state.natural_resource_index(@market.related_natural_resource) /
              FuelMarket::LOCAL_RESOURCE_SCALE_FACTOR)
      end

      it "should have a current price a specific city" do
        @market.current_local_price(@city).should eq(
            @market.current_price(@city.game) *
            ((100.0 - @market.discount_for(@city)) / 100.0))
      end

      it "should grab the most recent price for current price" do
        new_price = 42
        @market.market_prices.create(:price => new_price, :game => @game)
        @market.current_price(@game).should eq(new_price)
      end

      it "should have the price for an arbitrary day" do
        @market.price_at(@game, Time.now).should eq(
            @market.current_price(@game))
      end

      it "should have a lower coal price in a city with coal"

      it "should average the price over all games" do
        sum = @market.games.inject(0) {|sum, game|
          sum + @market.current_price(game)
        }
        @market.average_price.should eq(sum / @market.games.length)
      end
    end

    it "should know the avg demand for the fuel on an arbitrary day in game" do
      @generator = Factory :generator, :city => @city,
          :generator_type => @generator_type, :created_at => 2.days.ago
      time = 1.day.ago
      average = @game.generators(@market).inject(0) {|demand, gen|
        if gen.created_at >= time
          demand
        else
          demand + gen.average_fuel_burn_rate(time)
        end
      }
      stub_time
      @market.average_demand(@game, time).should eq(average)
    end

    it "should only count generators that exist in the average demand" do
      @market.average_demand(@game, 1.day.ago).should eq(0)
    end

    context "clearing market" do
      before do
        @market.clear @game
        @original_price = @market.current_price @game
        @another_market = Factory :fuel_market, :supply_slope => 2
        @another_price = Factory :market_price, :fuel_market => @another_market,
            :price => @price.price, :game => @game
        @another_generator_type = Factory :generator_type,
            :fuel_market => @another_market
        @another_generator = Factory :generator, :city => @city,
            :generator_type => @another_generator_type
      end

      it "should not recalculate price the first time the market clears" do
        @another_market.clear(@game)
        @another_market.current_price(@game).should eq(@original_price)
      end

      it "should recalculate prices based on supply of fuel"

      it "should recalculate prices based on demand" do 
        another_generator = Factory :generator, :city => @city,
            :generator_type => @generator_type
        @market.reload
        @market.clear(@game)
        @market.current_price(@game).should be > @original_price
      end
    end
  end
end
