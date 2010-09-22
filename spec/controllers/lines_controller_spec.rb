require 'spec_helper'

describe LinesController do
  before :all do
    @model = Line
    @instance = Factory :line
  end

  it_should_behave_like "a technical component instance"
end
