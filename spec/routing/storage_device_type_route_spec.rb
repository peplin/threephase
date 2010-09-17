require 'spec_helper'

describe "routing to storage device types" do
  before :all do
    @type = StorageDeviceType.all.first
  end

  it { {:get, "/stores/types"}.should route_to(:action => :index,
        :controller => "storage_device_types") }

  it { {:get, "/stores/types/new"}.should route_to(:action => :new,
      :controller => "storage_device_types") }

  it { {:post, "/stores/types"}.should route_to(:action => :create,
      :controller => "storage_device_types") }

  it { {:get, "/stores/type/#{@type}"}.should route_to(:action => :show,
        :id => @type, :controller => "storage_device_types") }

  it { {:get, "/stores/type/#{@type}/edit"}.should route_to(:action => :show,
        :id => @type, :controller => "storage_device_types") }

  it { {:put, "/stores/type/#{@type}"}.should route_to(:action => :update,
        :id => @type, :controller => "storage_device_types") }

  it { {:delete, "/stores/type/#{@type}"}.should route_to(:action => :delete,
        :id => @type, :controller => "storage_device_types") }
end
