require 'spec_helper'

describe GeneratorTypesController do
  before :all do
    @model = GeneratorType
  end

  it_should_behave_like "a technical component type"
end
