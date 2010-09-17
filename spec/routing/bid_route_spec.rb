require 'spec_helper'

describe "routing to bids" do
  before :all do
    @generator = Generator.all.first
    @game = Game.all.first
    @bid = Bid.all.first
  end

  it { {:get, "/game/#{@game}/bids"}.should route_to(:action => :index,
        :game => @game, :controller => "bids") }

  it { {:get, "/generator/#{@generator}/bids"}.should route_to(:action => :index,
        :generator => @generator, :controller => "bids") }

  it { {:get, "/generator/#{@generator}/bids/new"}.should route_to(:action => :new,
      :game => @game, :controller => "bids") }

  it { {:post, "/generator/#{@generator}/bids"}.should route_to(:action => :create,
      :generator => @generator, :controller => "bids") }

  it { {:get, "/generator/#{@generator}/bid/#{@bid}"}.should route_to(:action => :show,
        :generator => @generator, :bid => @bid, :controller => "bids") }

  it { {:get, "/game/#{@game}/bid/#{@bid}"}.should route_to(:action => :show,
        :game => @game, :bid => @bid, :controller => "bids") }

  it { {:get, "/bid/#{@bid}"}.should route_to(:action => :show,
        :bid => @bid, :controller => "bids") }

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
