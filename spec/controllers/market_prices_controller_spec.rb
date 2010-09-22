require 'spec_helper'

describe MarketPricesController do
  before :all do
    @model = Market
  end

  before :each do
    @game = Factory :game
    @market = Factory :market
    @zone = Factory :zone
  end

  context "as an admin" do
    before do
      Factory :admin_user_session
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "show with a game"
  end
end
