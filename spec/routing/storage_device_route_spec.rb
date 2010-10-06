require 'spec_helper'

describe "routing to storage-devices" do
  before :all do
    @game = Factory(:game).to_param
    @store = Factory(:storage_device).to_param
    @zone = Factory(:zone).to_param
  end

  it "should expose a list of a game's storage devices" do
    {:get => "/games/#{@game}/storage-devices"}.should route_to(
      :action => "index", :game_id => @game, :controller => "storage_devices") 
  end

  it "should expose a list of a zone's storage devices" do
    {:get => "/games/#{@game}/zones/#{@zone}/storage-devices"}.should route_to(
      :action => "index", :game_id => @game, :zone_id => @zone,
      :controller => "storage_devices") 
  end

  it { {:get => "/games/#{@game}/zones/#{@zone}/storage-devices/new"
      }.should route_to(:action => "new", :game_id => @game, :zone_id => @zone,
      :controller => "storage_devices") }

  it { {:post => "/storage-devices"}.should route_to(:action => "create",
      :controller => "storage_devices") }

  it "should expose a hackable URL to a game's storage device" do
    {:get => "/games/#{@game}/storage-devices/#{@store}"
        }.should route_to(:action => "show", :game_id => @game, :id => @store,
        :controller => "storage_devices") 
  end

  it "should expose a hackable URL to a zone's storage device" do
    {:get => "/games/#{@game}/zones/#{@zone}/storage-devices/#{@store}"
        }.should route_to(:action => "show", :game_id => @game,
        :zone_id => @zone, :id => @store, :controller => "storage_devices") 
  end

  it "should expose a direct URL to a storage device" do
    {:get => "/storage-devices/#{@store}"}.should route_to(:action => "show",
        :id => @store, :controller => "storage_devices")
  end

  it "should expose a hackable URL to edit a zone's storage device" do
    {:get => "/games/#{@game}/zones/#{@zone}/storage-devices/#{@store}/edit"
        }.should route_to(:action => "edit", :game_id => @game,
        :zone_id => @zone, :id => @store, :controller => "storage_devices")
  end

  it "should expose a hackable URL to edit a game's storage device" do
    {:get => "/games/#{@game}/storage-devices/#{@store}/edit"}.should route_to(
        :action => "edit", :game_id => @game, :id => @store,
        :controller => "storage_devices")
  end

  it "should expose a direct URL to edit a storage device" do
    {:get => "/storage-devices/#{@store}/edit"}.should route_to(:action => "edit",
      :id => @store, :controller => "storage_devices")
  end

  it { {:put => "/storage-devices/#{@store}"}.should route_to(:action => "update",
        :id => @store, :controller => "storage_devices") }

  it "does not expose a list of all storage-devices" do
    {:get => "/storage-devices"}.should_not be_routable
  end
end
