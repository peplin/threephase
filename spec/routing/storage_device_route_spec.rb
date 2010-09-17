require 'spec_helper'

describe "routing to stores" do
  before :all do
    @game = Game.all.first
    @store = StorageDevice.all.first
    @zone = Zone.all.first
  end

  it { {:get, "/game/#{@game}/stores"}.should route_to(:action => :index,
        :game => @game, :controller => "storage_devices") }

  it { {:get, "/game/#{@game}/zone/#{@zone}/stores"}.should route_to(
      :action => :index, :game => @game, :zone => @zone,
      :controller => "storage_devices") }

  it { {:get, "/game/#{@game}/store/new"}.should route_to(:action => :new,
      :game => @game, :controller => "storage_devices") }

  it { {:get, "/game/#{@game}/zone/#{@zone}/store/new"}.should route_to(
      :action => :new, :game => @game, :zone => @zone,
      :controller => "storage_devices") }

  it { {:post, "/stores"}.should route_to(:action => :create,
      :controller => "storage_devices") }

  it { {:get, "/store/#{@store}"}.should route_to(:action => :show,
        :id => @store, :controller => "storage_devices") }

  it { {:get, "/store/#{@store}/edit"}.should route_to(:action => :edit,
        :id => @store, :controller => "storage_devices") }

  it { {:put, "/store/#{@store}"}.should route_to(:action => :update,
        :id => @store, :controller => "storage_devices") }

  it "does not expose a list of all stores" do
    {:get => "/stores"}.should_not be_routable
  end
end
