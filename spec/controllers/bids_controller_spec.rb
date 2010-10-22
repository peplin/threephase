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

    context "POST" do
      it_should_behave_like "standard POST create"

      def redirect_path
        generator_path assigns(:bid).generator
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
