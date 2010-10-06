require 'spec_helper'

describe ResearchAdvancementsController do
  before :all do
    @model = ResearchAdvancement
  end

  context "as an admin" do
    before :all do
      @state = Factory :state
    end

    before do
      State.stubs(:find_by_game).returns(@state)
      login_as_admin
    end

    it_should_behave_like "standard GET index"
  end
end
