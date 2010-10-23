require 'spec_helper'

describe StatesController do
  before :all do
    @model = State
  end

  before do
    @game = Factory :game
    User.any_instance.stubs(:current_game).returns(@game)
  end

  context "as an admin" do
    before do
      login_as_admin
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "standard GET show"
    it_should_behave_like "standard PUT update"
  end

  context "as a player" do
    before do
      login
    end

    context "for a state not mine" do 
      it_should_behave_like "standard unsuccessful PUT update"
    end
  end
end
