require 'spec_helper'

describe InterstateLinesController do
  before :all do
    @model = InterstateLine
  end

  before :all do
    @region = Factory :region
  end

  before do
    Region.stubs(:find_by_game).returns(@region)
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

    context ":index with a region" do
      before :all do
        @region = Factory :region
      end

      it_should_behave_like "successful GET index"

      it "should only include lines in the region" do
        do_get
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
