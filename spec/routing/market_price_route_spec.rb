require 'spec_helper'

describe "routing to market_prices" do
  it { {:get, "/game/1/market_prices"}.should route_to(:action => :index,
      :game => 1, :controller => "market_prices") }

  it { {:get, "/game/1/zone/2/market_prices"}.should route_to(:action => :index,
      :game => 1, :zone => 2, :controller => "market_prices") }

  it { {:get, "/game/1/market_price/1"}.should route_to(:action => :show,
        :game => 1, :id => 1, :controller => "market_prices") }

  it { {:get, "/game/1/zone/2/market_price/1"}.should route_to(:action => :show,
        :game => 1, :zone => 2, :id => 1, :controller => "market_prices") }

  it "does not expose a list of all market_prices" do
    {:get => "/market_prices"}.should_not be_routable
  end
end
