require 'spec_helper'

describe "routing to storage device types" do
  before do
    @type = Factory(:storage_device_type).to_param
  end

  it { {:get, "/stores/types"}.should route_to(:action => "index",
        :controller => "storage_device_types") }

  it { {:get, "/stores/types/new"}.should route_to(:action => "new",
      :controller => "storage_device_types") }

  it { {:post, "/stores/types"}.should route_to(:action => "create",
      :controller => "storage_device_types") }

  it { {:get, "/stores/types/#{@type}"}.should route_to(
      :action => "show", :id => @type, :controller => "storage_device_types") }

  it { {:get, "/stores/types/#{@type}/edit"}.should route_to(
      :action => "edit", :id => @type, :controller => "storage_device_types") }

  it { {:put, "/stores/types/#{@type}"}.should route_to(
      :action => "update", :id => @type, :controller => "storage_device_types") }

  it { {:delete, "/stores/types/#{@type}"}.should route_to(
      :action => "destroy", :id => @type, :controller => "storage_device_types") }
end
