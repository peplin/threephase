require 'spec_helper'

describe ResearchAdvancementsController do
  before :all do
    @model = ResearchAdvancement
  end

  context "as an admin" do
    before do
      Region.stubs(:find_by_game).returns(Factory :region)
      login_as_admin
    end

    it_should_behave_like "index with a game"
  end
end
