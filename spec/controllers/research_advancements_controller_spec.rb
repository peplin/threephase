require 'spec_helper'

describe ResearchAdvancementsController do
  before :all do
    @model = ResearchAdvancement
  end

  context "as an admin" do
    before :all do
      Factory :admin_user_session
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "standard GET show"
  end
end
