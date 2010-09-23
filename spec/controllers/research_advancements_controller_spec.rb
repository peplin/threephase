require 'spec_helper'

describe ResearchAdvancementsController do
  before :all do
    @model = ResearchAdvancement
  end

  before :each do
    @game = Factory :game
    @advancement = Factory :research_advancement
  end

  context "as an admin" do
    before do
      Factory :admin_user_session
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "standard GET show"
  end
end
