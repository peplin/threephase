require 'spec_helper'

describe "routing to market_prices" do
  before :each do
    @game = Factory(:game).to_param
    @zone = Factory(:zone).to_param
    @market = Factory(:market).to_param
  end

  it "should expose a list of a game's market prices" do
    {:get, "/games/#{@game}/prices"}.should route_to(:action => "index",
      :game_id => @game, :controller => "market_prices")
  end

  it "should expose a list of a zone's market prices" do
    {:get, "/games/#{@game}/zones/#{@zone}/prices"}.should route_to(
      :action => "index", :game_id => @game, :zone_id => @zone,
      :controller => "market_prices")
  end

  it "should expose a hackable URL to a game's market price" do
    {:get, "/games/#{@game}/prices/#{@market}"}.should route_to(
      :action => "show", :game_id => @game, :id => @market,
      :controller => "market_prices")
  end

  it "should expose a hackable URL to zone's market price" do
    {:get, "/games/#{@game}/zones/#{@zone}/prices/#{@market}"
      }.should route_to(:action => "show", :game_id => @game, :zone_id => @zone,
      :id => @market, :controller => "market_prices")
  end

  it "does not expose a list of all market_prices" do
    {:get => "/prices"}.should_not be_routable
  end
end
