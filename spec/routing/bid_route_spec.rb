require 'spec_helper'

describe "routing to bids" do
  before :all do
    @generator = Factory(:generator).to_param
    @game = Factory(:game).to_param
    @bid = Factory(:bid).to_param
  end

  it "should expose a list of all bids in a game" do
    {:get, "/games/#{@game}/bids"}.should route_to(:action => "index",
        :game_id => @game, :controller => "bids")
  end

  it "should expose a list of all bids for a game's generator" do
    {:get, "/games/#{@game}/generators/#{@generator}/bids"}.should route_to(
        :action => "index", :game_id => @game, :generator_id => @generator,
        :controller => "bids")
  end

  it "should expose a list of all bids for a generator" do
    {:get, "/generators/#{@generator}/bids"}.should route_to(
        :action => "index", :generator_id => @generator,
        :controller => "bids")
  end

  it "should expose a new bid form for a generator" do
    {:get, "/games/#{@game}/generators/#{@generator}/bids/new"
        }.should route_to(:action => "new", :game_id => @game,
        :generator_id => @generator, :controller => "bids")
    {:get, "/generators/#{@generator}/bids/new"
        }.should route_to(:action => "new", :generator_id => @generator,
        :controller => "bids")
  end

  it { {:post, "/bids"}.should route_to(:action => "create",
      :controller => "bids") }

  it "should expose a hackable URL to a game's bid" do
    {:get, "/games/#{@game}/bids/#{@bid}"}.should route_to(
        :action => "show", :game_id => @game, :id => @bid,
        :controller => "bids")
  end

  it "should expose a hackable URL to a game's generator's bid" do
    {:get, "/games/#{@game}/generators/#{@generator}/bids/#{@bid}"
        }.should route_to(:action => "show", :game_id => @game,
        :generator_id => @generator, :id => @bid, :controller => "bids")
  end

  it "should expose a hackable URL to a generator's bid" do
    {:get, "/generators/#{@generator}/bids/#{@bid}"
        }.should route_to(:action => "show", :generator_id => @generator,
        :id => @bid, :controller => "bids")
  end

  it "should expose a direct URL to a bid" do
    {:get, "/bids/#{@bid}"}.should route_to(:action => "show",
        :id => @bid, :controller => "bids")
  end

  it "does not expose a master list of bids" do
    {:get => "/bids"}.should_not be_routable
  end

  it "does not allow bid updating" do
    {:put => "/generators/#{@generator}/bid/#{@bid}"}.should_not be_routable
    {:put => "/bids/#{@bid}"}.should_not be_routable
  end

  it "does not allow bid deleting" do
    {:delete => "/generators/#{@generator}/bids/#{@bid}"}.should_not be_routable
    {:delete => "/bids/#{@bid}"}.should_not be_routable
  end
end
