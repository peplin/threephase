require 'spec_helper'

describe "routing to market_prices" do
  before :all do
    @game = Factory(:game).to_param
    @city = Factory(:city).to_param
    @fuel_market = Factory(:fuel_market).to_param
  end

  it "should expose a list of a game's market prices" do
    {:get => "/games/#{@game}/prices"}.should route_to(:action => "index",
      :game_id => @game, :controller => "fuel_markets")
  end

  it "should expose a list of the current game's market prices" do
    {:get => "/prices"}.should route_to(:action => "index",
    :controller => "fuel_markets")
  end

  it "should expose a direct URL to a list of a city's market prices" do
    {:get => "/cities/#{@city}/prices"}.should route_to(
      :action => "index", :city_id => @city, :controller => "fuel_markets")
  end

  it "should expose a hackable URL to a game's market price" do
    {:get => "/games/#{@game}/prices/#{@fuel_market}"}.should route_to(
      :action => "show", :game_id => @game, :id => @fuel_market,
      :controller => "fuel_markets")
  end

  it "should expose a direct URL to the current game's market price" do
    {:get => "/prices/#{@fuel_market}"}.should route_to(
      :action => "show", :id => @fuel_market, :controller => "fuel_markets")
  end

  it "should expose a direct URL to city's market price" do
    {:get => "/cities/#{@city}/prices/#{@fuel_market}" }.should route_to(
      :action => "show", :city_id => @city, :id => @fuel_market,
      :controller => "fuel_markets")
  end
end
