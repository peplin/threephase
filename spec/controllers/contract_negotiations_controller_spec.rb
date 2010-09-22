require 'spec_helper'

describe ContractNegotiationsController do
  before :all do
    @model = ContractNegotiation
    @assigns_model_name = :contract
    @pluralized_assigns_model_name = :contracts
  end

  before :each do
    @generator = Factory :generator
    @offer = Factory :contract_offer
    @contract = Factory :contract_negotiation
    @game = Factory :game
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
      before :all do
        @model = ContractOffer
      end

      context "to POST" do
        it_should_behave_like "successful POST create"

        def do_post format='html'
          post :offer, :contract_offer => @offer.attributes, :format => format
        end
      end

      it_should_behave_like "standard PUT update"

      def redirect_path
        contract_negotiation_path @contract
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
