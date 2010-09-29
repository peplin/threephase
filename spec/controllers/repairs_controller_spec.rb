require 'spec_helper'

describe RepairsController do
  before :all do
    @model = Repair
  end

  context "as an admin" do
    before :all do
      @region = Factory :region
    end

    before do
      Region.stubs(:find_by_game).returns(@region)
      login_as_admin
    end

    it_should_behave_like "index with a game"
  end
end
