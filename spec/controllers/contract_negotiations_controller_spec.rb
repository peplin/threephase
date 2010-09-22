require 'spec_helper'

describe ContractNegotiationsController do
  before :all do
    @model = ContractNegotiation
  end

  before :each do
    @generator = Factory :generator
    @offer = Factory :contract_offer
    @contract = Factory :contract_negotiation
  end
  context "as an admin" do
    before do
      Factory :admin_user_session
    end
    
    it_should_behave_like "index with a game"
    it_should_behave_like "new with a game"
    it_should_behave_like "standard GET show"
    it_should_behave_like "standard POST create"

    context "with an offer" do
      before do
        @model = ContractOffer
      end

      it_should_behave_like "standard POST create"
      it_should_behave_like "standard PUT update"

      def redirect_path
        generator_contract_path @generator, @contract
      end
    end
  end

  context "as a player" do
    before do
      Factory :user_session
    end

    context "index with unauthorized objects" do
      it "should not allow access if user isn't in the game"
      it "should not allow access if user doesn't own the generator"
    end
  end
end
