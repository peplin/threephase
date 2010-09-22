require 'spec_helper'

describe ZonesController do
  before :all do
    @model = Zone
  end

  before do
    @game = Factory :game
    @data = Factory(:zone).attributes
  end

  context "as an admin" do
    before do
      Factory :admin_user_session
    end

    context "on GET to :index with a game" do
      it_should_behave_like "GET index"

        def do_get format='html'
          get :index, :game_id => @game, :format => format
        end
    end

    it_should_behave_like "standard POST create"
    it_should_behave_like "standard GET show"
  end
end
