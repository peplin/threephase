require 'spec_helper'

describe StorageDeviceTypesController do
  before :all do
    @model = StorageDeviceType
  end

  it_should_behave_like "a technical component type"
end
