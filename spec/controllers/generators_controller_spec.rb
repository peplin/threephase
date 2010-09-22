require 'spec_helper'

describe GeneratorsController do
  before :all do
    @model = Generator
    @instance = Factory :generator
  end

  it_should_behave_like "a technical component instance"
end
