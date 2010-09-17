require 'spec_helper'

describe "routing to market_prices" do
  before :all do
    @game = Game.all.first
    @zone = Zone.all.first
    @market = Market.all.first
  end

  it { {:get, "/game/#{@game}/market-prices"}.should route_to(:action => :index,
      :game => @game, :controller => "market_prices") }

  it { {:get, "/game/#{@game}/zone/#{@zone}/market-prices"}.should route_to(
      :action => :index, :game => @game, :zone => @zone,
      :controller => "market_prices") }

  it { {:get, "/game/#{@game}/market-price/#{@market}"}.should route_to(
      :action => :show, :game => @game, :id => @market,
      :controller => "market_prices") }

  it { {:get, "/game/#{@game}/zone/#{@zone}/market-price/#{@market}"
      }.should route_to(:action => :show, :game => @game, :zone => @zone,
      :id => @market, :controller => "market_prices") }

  it "does not expose a list of all market_prices" do
    {:get => "/market_prices"}.should_not be_routable
  end
end
