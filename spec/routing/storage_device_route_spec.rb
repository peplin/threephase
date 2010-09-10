require 'spec_helper'

describe "routing to stores" do
  it { {:get, "/game/1/stores"}.should route_to(:action => :index,
        :game => 1, :controller => "storage_devices") }

  it { {:get, "/game/1/zone/2/stores"}.should route_to(
      :action => :index, :game => 1, :zone => 2, :controller => "storage_devices") }

  it { {:get, "/game/1/store/new"}.should route_to(:action => :new,
      :game => 1, :controller => "storage_devices") }

  it { {:get, "/game/1/zone/2/store/new"}.should route_to(:action => :new,
      :game => 1, :zone => 2, :controller => "storage_devices") }

  it { {:post, "/stores"}.should route_to(:action => :create,
      :controller => "storage_devices") }

  it { {:get, "/store/1"}.should route_to(:action => :show,
        :id => 1, :controller => "storage_devices") }

  it { {:edit, "/store/1"}.should route_to(:action => :show,
        :id => 1, :controller => "storage_devices") }

  it { {:put, "/store/1"}.should route_to(:action => :update,
        :id => 1, :controller => "storage_devices") }

  it "does not expose a list of all stores" do
    {:get => "/stores"}.should_not be_routable
  end
end
