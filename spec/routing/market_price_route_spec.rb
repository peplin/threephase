require 'spec_helper'

describe "routing to market_prices" do
  before :each do
    @game = Factory(:game).to_param
    @zone = Factory(:zone).to_param
    @market = Factory(:market).to_param
  end

  it "should expose a list of a game's market prices" do
    {:get, "/games/#{@game}/market-prices"}.should route_to(:action => "index",
      :game => @game, :controller => "market_prices")
  end

  it "should expose a list of a zone's market prices" do
    {:get, "/games/#{@game}/zones/#{@zone}/market-prices"}.should route_to(
      :action => "index", :game => @game, :zone => @zone,
      :controller => "market_prices")
  end

  it "should expose a hackable URL to a game's market price" do
    {:get, "/games/#{@game}/market-prices/#{@market}"}.should route_to(
      :action => "show", :game => @game, :id => @market,
      :controller => "market_prices")
  end

  it "should expose a hackable URL to zone's market price" do
    {:get, "/games/#{@game}/zones/#{@zone}/market-prices/#{@market}"
      }.should route_to(:action => "show", :game => @game, :zone => @zone,
      :id => @market, :controller => "market_prices")
  end

  it "does not expose a list of all market_prices" do
    {:get => "/market_prices"}.should_not be_routable
  end
end
