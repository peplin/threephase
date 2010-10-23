require 'spec_helper'

describe Market do
  it { should have_many :market_prices }
  it { should have_many :fuel_types }
  it { should validate_presence_of :name }
  it { should validate_presence_of :average_price }
  it { should validate_presence_of :standard_deviation }

  it { should respond_to :friendly_id }

  context "A Market instance" do
    before :all do
      @price = Factory :market_price
      @market = @price.market
      @game = @price.game
      @state = Factory :state, :game => @game
      @city = Factory :city, :state => @state
    end

    it "should have a current price for the overall market" do
      (@market.current_price @game).should eq(
          @game.market_prices.find_by_market_id(@market).price)
    end
  end
end
