require 'spec_helper'

describe Market do
  it { should have_many :market_prices }
  it { should have_many :fuel_types }
  it { should validate_presence_of :name }

  it { should respond_to :friendly_id }

  context "A Market instance" do
    before :all do
      @market = Factory :market
      @game = Factory :game
      @region = Factory :region, :game => @game
      @zone = Factory :zone, :region => @region
    end

    it "should have a current price for the overall market" do
      (@market.current_price @game).should eq(
          @game.market_prices.find_by_market(@market).first.price)
    end
  end
end
