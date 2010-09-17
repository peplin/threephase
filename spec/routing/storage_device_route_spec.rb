require 'spec_helper'

describe "routing to storage-devices" do
  before :all do
    @game = Game.all.first
    @store = StorageDevice.all.first
    @zone = Zone.all.first
  end

  it "should expose a list of a game's storage devices" do
    {:get, "/games/#{@game}/storage-devices"}.should route_to(
      :action => :index, :game => @game, :controller => "storage_devices") 
  end

  it "should expose a list of a zone's storage devices" do
    {:get, "/games/#{@game}/zones/#{@zone}/storage-devices"}.should route_to(
      :action => :index, :game => @game, :zone => @zone,
      :controller => "storage_devices") 
  end

  it { {:get, "/games/#{@game}/zones/#{@zone}/storage-devices/new"
      }.should route_to(:action => :new, :game => @game, :zone => @zone,
      :controller => "storage_devices") }

  it { {:post, "/storage-devices"}.should route_to(:action => :create,
      :controller => "storage_devices") }

  it "should expose a hackable URL to a game's storage device" do
    {:get, "/games/#{@game}/storage-devices/#{@store}"
        }.should route_to(:action => :show, :game => @game, :id => @store,
        :controller => "storage_devices") 
  end

  it "should expose a hackable URL to a zone's storage device" do
    {:get, "/games/#{@game}/zones/#{@zone}/storage-devices/#{@store}"
        }.should route_to(:action => :show, :game => @game, :zone => @zone,
        :id => @store, :controller => "storage_devices") 
  end

  it "should expose a direct URL to a storage device" do
    {:get, "/storage-devices/#{@store}"}.should route_to(:action => :show,
        :id => @store, :controller => "storage_devices")
  end

  it "should expose a hackable URL to edit a zone's storage device" do
    {:get, "/games/#{@game}/zones/#{@zone}/storage-devices/#{@store}/edit"
        }.should route_to(:action => :edit, :game => @game, :zone => @zone,
        :id => @store, :controller => "storage_devices")
  end

  it "should expose a hackable URL to edit a game's storage device" do
    {:get, "/games/#{@game}/storage-devices/#{@store}/edit"}.should route_to(
        :action => :edit, :game => @game, :id => @store,
        :controller => "storage_devices")
  end

  it "should expose a direct URL to edit a storage device" do
    {:get, "/storage-devices/#{@store}/edit"}.should route_to(:action => :edit,
      :id => @store, :controller => "storage_devices")
  end

  it { {:put, "/storage-devices/#{@store}"}.should route_to(:action => :update,
        :id => @store, :controller => "storage_devices") }

  it "does not expose a list of all storage-devices" do
    {:get => "/storage-devices"}.should_not be_routable
  end
end
