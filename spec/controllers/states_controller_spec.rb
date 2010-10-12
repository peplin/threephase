require 'spec_helper'

describe StatesController do
  before :all do
    @model = State
  end

  context "as an admin" do
    before do
      login_as_admin
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "standard GET index"
    it_should_behave_like "standard GET show"
    it_should_behave_like "standard PUT update"
  end

  context "as a player" do
    it "should not allow me to update states not mine"
  end
end