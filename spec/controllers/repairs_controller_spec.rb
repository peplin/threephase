require 'spec_helper'

describe RepairsController do
  before :all do
    @model = Repair
  end

  context "as an admin" do
    before do
      login_as_admin
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "standard GET show"
  end
end
