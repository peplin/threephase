require 'spec_helper'

describe Market do
  it { should have_many :market_prices }
  it { should have_many :fuel_types }
  it { should have_many(:games).through(:market_prices) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :initial_average_price }
  it { should validate_presence_of :initial_standard_deviation }

  it { should respond_to :friendly_id }

  it "should initialize for a game based on average price and std. dev." do
    market = Factory :market
    game = Factory :game
    proc { market.initialize_for(game) }.should change(
        MarketPrice, :count).by(1)
    price = market.market_prices.find_by_game_id(game)
    price.price.should be >= market.initial_average_price - market.initial_standard_deviation
    price.price.should be <= market.initial_average_price + market.initial_standard_deviation
  end

  context "A Market instance" do
    before :all do
      @price = Factory :market_price
      @market = @price.market
      @game = @price.game
      @state = Factory :state, :game => @game
      @city = Factory :city, :state => @state
      @another_price = Factory :market_price
      @another_game = @another_price.game
      @another_state = Factory :another_state, :game => @another_game
      @another_city = Factory :another_city, :state => @another_state
    end

    it "should have a current price for the overall market in a game" do
      (@market.current_price(@game)).should eq(
          @game.market_prices.find_by_market_id(@market).price)
    end

    it "should have a current price a specific city" do
      (@market.current_local_price(@city)).should eq(
          @game.market_prices.find_by_market_id(@market).price)
    end

    it "should have a lower coal price in a city with coal"

    it "should average the price over all games" do
      sum = @market.games.inject(0) {|sum, game|
        sum + @market.current_price(game)
      }
      @market.average_price.should eq(sum / @market.games.length)
    end
  end
end
