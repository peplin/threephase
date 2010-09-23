require 'spec_helper'

describe RegionsController do
  before :all do
    @model = Region
  end

  context "as an admin" do
    it_should_behave_like "index with a game"
    it_should_behave_like "standard GET show"
    it_should_behave_like "standard PUT update"
  end

  context "as a player" do
    it "should not allow me to update regions not mine"
  end
end
