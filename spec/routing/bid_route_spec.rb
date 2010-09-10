require 'spec_helper'

describe "routing to bids" do
  it { {:get, "/game/1/bids"}.should route_to(:action => :index,
        :game => 1, :controller => "bids") }

  it { {:get, "/generator/1/bids"}.should route_to(:action => :index,
        :generator => 1, :controller => "bids") }

  it { {:get, "/generator/1/bids/new"}.should route_to(:action => :new,
      :game => 1, :controller => "bids") }

  it { {:post, "/generator/1/bids"}.should route_to(:action => :create,
      :generator => 1, :controller => "bids") }

  it "does not show individual bids" do
    {:get => "/generator/1/bid/1"}.should_not be_routable
  end

  it "does not allow bid updating" do
    {:put => "/generator/1/bid/1"}.should_not be_routable
  end

  it "does not allow bid deleting" do
    {:delete => "/generator/1/bids/1"}.should_not be_routable
  end
end
