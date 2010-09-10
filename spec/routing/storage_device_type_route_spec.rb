require 'spec_helper'

describe "routing to storage device types" do
  it { {:get, "/game/1/stores/types"}.should route_to(:action => :index,
        :game => 1, :controller => "storage_device_types") }

  it { {:get, "/stores/types"}.should route_to(:action => :index,
        :controller => "storage_device_types") }

  it { {:get, "/stores/types/new"}.should route_to(:action => :new,
      :controller => "storage_device_types") }

  it { {:post, "/stores/types"}.should route_to(:action => :create,
      :controller => "storage_device_types") }

  it { {:get, "/stores/type/1"}.should route_to(:action => :show,
        :id => 1, :controller => "storage_device_types") }

  it { {:edit, "/stores/type/1"}.should route_to(:action => :show,
        :id => 1, :controller => "storage_device_types") }

  it { {:put, "/stores/type/1"}.should route_to(:action => :update,
        :id => 1, :controller => "storage_device_types") }

  it { {:delete, "/stores/type/1"}.should route_to(:action => :delete,
        :id => 1, :controller => "storage_device_types") }
end
