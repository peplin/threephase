require 'spec_helper'

describe InterstateLinesController do
  before :all do
    @model = InterstateLine
  end

  before :all do
    @state = Factory :state
  end

  before do
    State.stubs(:find_by_game).returns(@state)
  end

  context "as an admin" do
    before do
      login_as_admin
    end

    it_should_behave_like "standard GET index"
    it_should_behave_like "standard GET new"
    it_should_behave_like "standard GET show"
    it_should_behave_like "standard POST create"
    it_should_behave_like "standard PUT update"

    context ":index with a state" do
      before :all do
        @state = Factory :state
      end

      it_should_behave_like "successful GET index"

      it "should only include lines in the state" do
        do_get
        assigns(:interstate_lines).each do |line|
          line.state.should eq(@state)
        end
      end

      def do_get format='html'
        get :index, :state_id => @state, :format => format
      end
    end
  end
end
