require 'spec_helper'

describe StorageDevicesController do
  before :all do
    @model = StorageDevice
    @instance = Factory :storage_device
  end

  it_should_behave_like "a technical component instance"
end
