require 'spec_helper'

describe "routing to generators" do
  it { {:get, "/game/1/generators"}.should route_to(:action => :index,
        :game => 1, :controller => "generators") }

  it { {:get, "/game/1/zone/2/generators"}.should route_to(
      :action => :index, :game => 1, :zone => 2, :controller => "generators") }

  it { {:get, "/game/1/generators/new"}.should route_to(:action => :new,
      :game => 1, :controller => "generators") }

  it { {:get, "/game/1/zone/2/generators/new"}.should route_to(:action => :new,
      :game => 1, :zone => 2, :controller => "generators") }

  it { {:post, "/generators"}.should route_to(:action => :create,
      :controller => "generators") }

  it { {:get, "/generator/1"}.should route_to(:action => :show,
      :id => 1, :controller => "generators") }

  it { {:get, "/generator/1/edit"}.should route_to(:action => :show,
      :id => 1, :controller => "generators") }

  it { {:put, "/generator/1"}.should route_to(:action => :update,
      :id => 1, :controller => "generators") }

  it "does not expose a list of all generators" do
    {:get => "/generators"}.should_not be_routable
  end
end
