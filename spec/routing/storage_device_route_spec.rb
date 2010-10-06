require 'spec_helper'

describe "routing to storage-devices" do
  before :all do
    @store = Factory(:storage_device).to_param
    @zone = Factory(:zone).to_param
  end

  it "should expose a list of the current game's storage devices" do
    {:get => "/storage-devices"}.should route_to(:action => "index",
        :controller => "storage_devices") 
  end

  it "should expose a list of a zone's storage devices" do
    {:get => "/zones/#{@zone}/storage-devices"}.should route_to(
      :action => "index", :zone_id => @zone, :controller => "storage_devices") 
  end

  it { {:get => "/zones/#{@zone}/storage-devices/new"
      }.should route_to(:action => "new", :zone_id => @zone,
      :controller => "storage_devices") }

  it { {:post => "/storage-devices"}.should route_to(:action => "create",
      :controller => "storage_devices") }

  it "should expose a hackable URL to a zone's storage device" do
    {:get => "/zones/#{@zone}/storage-devices/#{@store}"
        }.should route_to(:action => "show", :zone_id => @zone, :id => @store,
        :controller => "storage_devices") 
  end

  it "should expose a direct URL to a storage device" do
    {:get => "/storage-devices/#{@store}"}.should route_to(:action => "show",
        :id => @store, :controller => "storage_devices")
  end

  it "should expose a hackable URL to edit a zone's storage device" do
    {:get => "/zones/#{@zone}/storage-devices/#{@store}/edit"
        }.should route_to(:action => "edit", :zone_id => @zone, :id => @store,
        :controller => "storage_devices")
  end

  it "should expose a direct URL to edit a storage device" do
    {:get => "/storage-devices/#{@store}/edit"}.should route_to(:action => "edit",
      :id => @store, :controller => "storage_devices")
  end

  it { {:put => "/storage-devices/#{@store}"}.should route_to(:action => "update",
        :id => @store, :controller => "storage_devices") }
end
