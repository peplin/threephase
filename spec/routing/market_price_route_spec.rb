require 'spec_helper'

describe "routing to market_prices" do
  before :all do
    @game = Factory(:game).to_param
    @zone = Factory(:zone).to_param
    @market = Factory(:market).to_param
  end

  it "should expose a list of a game's market prices" do
    {:get => "/games/#{@game}/prices"}.should route_to(:action => "index",
      :game_id => @game, :controller => "markets")
  end

  it "should expose a list of the current game's market prices" do
    {:get => "/prices"}.should route_to(:action => "index", :controller => "markets")
  end

  it "should expose a direct URL to a list of a zone's market prices" do
    {:get => "/zones/#{@zone}/prices"}.should route_to(
      :action => "index", :zone_id => @zone, :controller => "markets")
  end

  it "should expose a hackable URL to a game's market price" do
    {:get => "/games/#{@game}/prices/#{@market}"}.should route_to(
      :action => "show", :game_id => @game, :id => @market,
      :controller => "markets")
  end

  it "should expose a direct URL to the current game's market price" do
    {:get => "/prices/#{@market}"}.should route_to(
      :action => "show", :id => @market, :controller => "markets")
  end

  it "should expose a direct URL to zone's market price" do
    {:get => "/zones/#{@zone}/prices/#{@market}" }.should route_to(
      :action => "show", :zone_id => @zone, :id => @market, :controller => "markets")
  end
end
