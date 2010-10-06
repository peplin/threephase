require 'spec_helper'

describe "routing to storage device types" do
  before :all do
    @type = Factory(:storage_device_type).to_param
  end

  it { {:get => "/storage-devices/types"}.should route_to(:action => "index",
        :controller => "storage_device_types") }

  it { {:get => "/storage-devices/types/new"}.should route_to(:action => "new",
      :controller => "storage_device_types") }

  it { {:post => "/storage-devices/types"}.should route_to(:action => "create",
      :controller => "storage_device_types") }

  it { {:get => "/storage-devices/types/#{@type}"}.should route_to(
      :action => "show", :id => @type, :controller => "storage_device_types") }

  it { {:get => "/storage-devices/types/#{@type}/edit"}.should route_to(
      :action => "edit", :id => @type, :controller => "storage_device_types") }

  it { {:put => "/storage-devices/types/#{@type}"}.should route_to(
      :action => "update", :id => @type, :controller => "storage_device_types") }

  it { {:delete => "/storage-devices/types/#{@type}"}.should route_to(
      :action => "destroy", :id => @type, :controller => "storage_device_types") }
end
