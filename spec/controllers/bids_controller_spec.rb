require 'spec_helper'

describe BidsController do
  before :all do
    @model = Bid
    @generator = Factory :generator
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
    it_should_behave_like "standard POST create"

    context ":new with a generator" do
      it_should_behave_like "successful GET new"

      def do_get format='html'
        get :new, :generator_id => @generator
      end
    end

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
    before :all do
      login
    end

    context "POST for a generator not owned by this user" do
      it "should return not authorized"
    end
  end
end
