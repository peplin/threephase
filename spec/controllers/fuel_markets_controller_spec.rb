require 'spec_helper'

describe FuelMarketsController do
  before :all do
    @model = FuelMarket
  end

  context "as an admin" do
    before do
      login_as_admin
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "show with a game"
  end
end
