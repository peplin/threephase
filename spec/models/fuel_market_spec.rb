require 'spec_helper'

describe FuelMarket do
  it { should have_many :market_prices }
  it { should have_many(:games).through(:market_prices) }
  it { should have_many :generator_types }
  it { should have_many(:generators).through(:generator_types) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :initial_average_price }
  it { should validate_presence_of :initial_standard_deviation }

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
      @city = Factory :city, :state => @state
      @another_price = Factory :market_price
      @another_game = @another_price.game
      @another_state = Factory :another_state, :game => @another_game
      @another_city = Factory :another_city, :state => @another_state
    end

    it { @market.friendly_id.should eq(@market.name.downcase) }

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

    it "should know the avg demand for the fuel on an arbitrary day in game" do
      average = @game.generators(@market).inject(0) {|demand, gen|
        demand + gen.average_fuel_burn_rate(1.day.ago)
      }
      @market.average_demand(@game, 1.day.ago).should eq(average)
    end

    it "should have a current price for the overall market in a game" do
      (@market.current_price(@game)).should eq(
          @game.market_prices.find_by_fuel_market_id(@market).price)
    end

    it "should have a current price a specific city" do
      (@market.current_local_price(@city)).should eq(
          @game.market_prices.find_by_fuel_market_id(@market).price)
    end

    it "should have a lower coal price in a city with coal"

    it "should average the price over all games" do
      sum = @market.games.inject(0) {|sum, game|
        sum + @market.current_price(game)
      }
      @market.average_price.should eq(sum / @market.games.length)
    end

    context "clearing market" do
      before do
        @market.clear @game
        @original_price = @market.current_price @game
      end
      it "should recalculate prices based on supply of fuel" do 
        @market.supply_slope *= 2
        @market.clear(@game)
        @market.current_price(@game).should be > @original_price
      end

      it "should recalculate prices based on demand" do 
        FuelMarket.any_instance.stubs(:average_demand).returns(0)
        @market.clear(@game)
        @market.current_price(@game).should be < @original_price
      end
    end
  end
end
