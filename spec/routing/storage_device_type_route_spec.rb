require 'spec_helper'

describe "routing to storage device types" do
  before :all do
    @type = Factory(:storage).to_param_device_type
  end

  it { {:get, "/games/#{@game}/storage-devices/types"}.should route_to(:action => "index",
      :game => @game, :type => StorageDeviceType,
      :controller => "allowed_technical_components") }

  it { {:post, "/games/#{@game}/storage-devices/types"}.should route_to(:action => "allow",
        :game => @game, :controller => "allowed_technical_components") }

  it { {:delete, "/games/#{@game}/storage-devices/types/#{@type}"}.should route_to(
      :action => "disallow", :game => @game, :type => @type,
      :controller => "allowed_technical_components") }

  it { {:get, "/storage-devices/types"}.should route_to(:action => "index",
        :controller => "storage_device_types") }

  it { {:get, "/storage-devices/types/new"}.should route_to(:action => "new",
      :controller => "storage_device_types") }

  it { {:post, "/storage-devices/types"}.should route_to(:action => "create",
      :controller => "storage_device_types") }

  it { {:get, "/storage-devices/type/#{@type}"}.should route_to(
      :action => "show", :id => @type, :controller => "storage_device_types") }

  it { {:get, "/storage-devices/type/#{@type}/edit"}.should route_to(
      :action => "show", :id => @type, :controller => "storage_device_types") }

  it { {:put, "/storage-devices/type/#{@type}"}.should route_to(
      :action => "update", :id => @type, :controller => "storage_device_types") }

  it { {:delete, "/storage-devices/type/#{@type}"}.should route_to(
      :action => "destroy", :id => @type, :controller => "storage_device_types") }
end
