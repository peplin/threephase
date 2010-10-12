require 'spec_helper'

describe StorageDevicesController do
  before :all do
    @model = StorageDevice
    @instance = Factory :storage_device
  end

  before do
    State.stubs(:find_by_game).returns(@instance.state)
  end

  it_should_behave_like "a technical component instance"
end
