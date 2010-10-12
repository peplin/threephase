require 'spec_helper'

describe RepairsController do
  before :all do
    @model = Repair
    @state = Factory :state
  end

  context "as an admin" do
    before do
      State.stubs(:find_by_game).returns(@state)
      User.any_instance.stubs(:current_game).returns(@state.game)
      login_as_admin
    end

    it_should_behave_like "index with a game"
  end
end
