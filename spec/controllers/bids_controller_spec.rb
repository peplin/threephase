require 'spec_helper'

describe BidsController do
  before :all do
    @model = Bid
  end

  before :each do
    @generator = Factory :generator
    @bid = Factory :bid
    @data = Factory(:bid).attributes
  end

  context "as an admin" do
    before do
      Factory :admin_user_session
    end

    context "on GET to" do
      context "for HTML" do
        context "on GET to :index with a game" do
          it_should_behave_like "GET index"

            def do_get format='html'
              get :index, :game_id => @game, :format => format
            end
        end

        it_should_behave_like "standard GET show"

        context ":new with a generator" do
          it_should_behave_like "successful GET new"
          def do_get format='html'
            get :new, :generator_id => @generator
          end
        end
      end
    end

    it_should_behave_like "standard POST create"

    context "on POST to :create" do
      context "for HTML" do
        context "when a bid already exists for today" do
          it "should return a 409 conflict"
        end

        context "when the game doesn't have rate of return regulation" do
          it "should return 403 forbidden"
        end
      end
    end
  end
  context "as a player" do
    before do
      Factory :user_session
    end

    context "POST for a generator not owned by this user" do
      it "should return not authorized"
    end
  end
end
