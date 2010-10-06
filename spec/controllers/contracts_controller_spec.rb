require 'spec_helper'

describe ContractsController do
  before :all do
    @model = Contract
    @assigns_model_name = :contract
    @pluralized_assigns_model_name = :contracts
  end

  context "as an admin" do
    before :all do
      @state = Factory :state
    end

    before do
      State.stubs(:find_by_game).returns(@state)
      login_as_admin
    end
    
    it_should_behave_like "standard GET index"
    it_should_behave_like "standard GET show"

    context "with an offer" do
      include CrudSetup

      before :all do
        @model = Offer
        setup_crud_names
        @offer = Factory :offer
      end

      context "to POST" do
        it_should_behave_like "successful POST create"

        def do_post format='html'
          post :offer, :offer => @offer.attributes, :format => format
        end
      end

      context "to PUT" do
        it_should_behave_like "successful PUT update"

        def do_put format='html'
          put :respond, :id => @offer, :offer => {:accepted => true},
              :format => format
        end
      end

      def redirect_path
        contract_path @offer.contract
      end
    end
  end

  context "as a player" do
    before :all do
      login
    end

    context "index with unauthorized objects" do
      it "should not allow access if user isn't in the game"
      it "should not allow access if user doesn't own the generator"
    end
  end
end
