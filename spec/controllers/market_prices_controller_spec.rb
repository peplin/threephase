require 'spec_helper'

describe MarketPricesController do
  before :all do
    @model = Market
  end

  context "as an admin" do
    before :all do
      Factory :admin_user_session
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "show with a game"
  end
end
