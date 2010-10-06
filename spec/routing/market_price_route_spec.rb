require 'spec_helper'

describe "routing to market_prices" do
  before :all do
    @game = Factory(:game).to_param
    @city = Factory(:city).to_param
    @market = Factory(:market).to_param
  end

  it "should expose a list of a game's market prices" do
    {:get => "/games/#{@game}/prices"}.should route_to(:action => "index",
      :game_id => @game, :controller => "markets")
  end

  it "should expose a list of the current game's market prices" do
    {:get => "/prices"}.should route_to(:action => "index", :controller => "markets")
  end

  it "should expose a direct URL to a list of a city's market prices" do
    {:get => "/cities/#{@city}/prices"}.should route_to(
      :action => "index", :city_id => @city, :controller => "markets")
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

  it "should expose a direct URL to city's market price" do
    {:get => "/cities/#{@city}/prices/#{@market}" }.should route_to(
      :action => "show", :city_id => @city, :id => @market, :controller => "markets")
  end
end
