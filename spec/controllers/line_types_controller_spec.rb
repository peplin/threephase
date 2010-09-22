require 'spec_helper'

describe LineTypesController do
  before :all do
    @model = LineType
  end

  it_should_behave_like "a technical component type"
end
