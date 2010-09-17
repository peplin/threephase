require 'spec_helper'

describe "routing to bids" do
  before :all do
    @generator = Generator.all.first
    @game = Game.all.first
    @bid = Bid.all.first
  end

  it "should expose a list of all bids in a game" do
    {:get, "/games/#{@game}/bids"}.should route_to(:action => :index,
        :game => @game, :controller => "bids")
  end

  it "should expose a list of all bids for a generator" do
    {:get, "/generator/#{@generator}/bids"}.should route_to(:action => :index,
        :generator => @generator, :controller => "bids")
  end

  it "should expose a new bid form for a generator" do
    {:get, "/generator/#{@generator}/bids/new"}.should route_to(:action => :new,
      :game => @game, :controller => "bids")
  end

  it { {:post, "/bids"}.should route_to(:action => :create,
      :controller => "bids") }

  it "should expose a hackable URL to a generator's bid" do
    {:get, "/generator/#{@generator}/bids/#{@bid}"}.should route_to(:action => :show,
        :generator => @generator, :bid => @bid, :controller => "bids")
  end

  it "should expose a direct URL to a bid" do
    {:get, "/bids/#{@bid}"}.should route_to(:action => :show,
        :bid => @bid, :controller => "bids")
  end

  it "does not expose a master list of bids" do
    {:get => "/bids"}.should_not be_routable
  end

  it "does not allow bid updating" do
    {:put => "/generator/#{@generator}/bid/#{@bid}"}.should_not be_routable
    {:put => "/bids/#{@bid}"}.should_not be_routable
  end

  it "does not allow bid deleting" do
    {:delete => "/generator/#{@generator}/bids/#{@bid}"}.should_not be_routable
    {:delete => "/bids/#{@bid}"}.should_not be_routable
  end
end
