require 'spec_helper'

describe ZonesController do
  before :all do
    @model = Zone
  end

  context "as an admin" do
    before :all do
      Factory :admin_user_session
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "standard POST create"
    it_should_behave_like "standard GET show"
  end
end
