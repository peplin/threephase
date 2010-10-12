require 'spec_helper'

describe LinesController do
  before :all do
    @model = Line
    @instance = Factory :line
  end

  before do
    State.stubs(:find_by_game).returns(@instance.state)
  end

  it_should_behave_like "a technical component instance"
end

