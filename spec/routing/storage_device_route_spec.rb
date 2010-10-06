require 'spec_helper'

describe "routing to storage-devices" do
  before :all do
    @store = Factory(:storage_device).to_param
    @city = Factory(:city).to_param
  end

  it "should expose a list of the current game's storage devices" do
    {:get => "/storage-devices"}.should route_to(:action => "index",
        :controller => "storage_devices") 
  end

  it "should expose a list of a city's storage devices" do
    {:get => "/cities/#{@city}/storage-devices"}.should route_to(
      :action => "index", :city_id => @city, :controller => "storage_devices") 
  end

  it { {:get => "/cities/#{@city}/storage-devices/new"
      }.should route_to(:action => "new", :city_id => @city,
      :controller => "storage_devices") }

  it { {:post => "/storage-devices"}.should route_to(:action => "create",
      :controller => "storage_devices") }

  it "should expose a hackable URL to a city's storage device" do
    {:get => "/cities/#{@city}/storage-devices/#{@store}"
        }.should route_to(:action => "show", :city_id => @city, :id => @store,
        :controller => "storage_devices") 
  end

  it "should expose a direct URL to a storage device" do
    {:get => "/storage-devices/#{@store}"}.should route_to(:action => "show",
        :id => @store, :controller => "storage_devices")
  end

  it "should expose a hackable URL to edit a city's storage device" do
    {:get => "/cities/#{@city}/storage-devices/#{@store}/edit"
        }.should route_to(:action => "edit", :city_id => @city, :id => @store,
        :controller => "storage_devices")
  end

  it "should expose a direct URL to edit a storage device" do
    {:get => "/storage-devices/#{@store}/edit"}.should route_to(:action => "edit",
      :id => @store, :controller => "storage_devices")
  end

  it { {:put => "/storage-devices/#{@store}"}.should route_to(:action => "update",
        :id => @store, :controller => "storage_devices") }
end
