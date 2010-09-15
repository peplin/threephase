require 'spec_helper'

describe "routing to regions" do
  it { {:get, "/game/1/regions"}.should route_to(:action => :index,
      :game => 1, :controller => "regions") }

  it { {:get, "/game/1/region/2"}.should route_to(:action => :show,
      :game => 1, :region => 2, :controller => "regions") }

  # TODO do we need post? how are players added to a game?

  it { {:put, "/game/1/region/2"}.should route_to(:action => :update,
      :game => 1, :region => 2, :controller => "regions") }

  it "does not expose a list of all regions" do
    {:get => "/regions"}.should_not be_routable
  end

  it "does not allow creating new regions" do
    {:post => "/game/1/regions"}.should_not be_routable
    {:post => "/regions"}.should_not be_routable
  end

  it "does not allow deleting of a region" do
    {:delete => "/generator/1/region/1"}.should_not be_routable
  end
end
