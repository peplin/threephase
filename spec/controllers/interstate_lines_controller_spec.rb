require 'spec_helper'

describe InterstateLinesController do
  before :all do
    @model = InterstateLine
  end

  before do
    @region = Factory :region
    Region.stubs(:find_by_game).returns(Factory :region)
  end

  context "as an admin" do
    before do
      login_as_admin
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "new with a game"
    it_should_behave_like "standard GET show"
    it_should_behave_like "standard POST create"
    it_should_behave_like "standard PUT update"

    context ":index with a region" do
      it_should_behave_like "successful GET index"

      it "should only include lines in the region" do
        assigns(:interstate_lines).each do |line|
          line.region.should eq(@region)
        end
      end

      def do_get format='html'
        get :index, :region_id => @region, :format => format
      end
    end
  end
end
