require 'spec_helper'

describe "routing to zones" do
  it { {:get, "/game/1/zones"}.should route_to(:action => :index,
      :game => 1, :controller => "zones") }

  it { {:get, "/game/1/region/2/zones"}.should route_to(:action => :index,
      :game => 1, :region => 2, :controller => "zones") }

  it { {:post, "/zones"}.should route_to(:action => :create,
      :controller => "zones") }

  it { {:get, "/zone/1"}.should route_to(:action => :show, :id => 1,
      :controller => "zones") }

  it "does not expose a list of all zones" do
    {:get => "/zones"}.should_not be_routable
  end

  it "does not allow editing of a zone" do
    {:put => "/generator/1/zone/1"}.should_not be_routable
  end

  it "does not allow deleting of a zone" do
    {:delete => "/generator/1/zone/1"}.should_not be_routable
  end
end
