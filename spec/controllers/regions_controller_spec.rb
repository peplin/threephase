require 'spec_helper'

describe RegionsController do
  before :all do
    @model = Region
  end

  before :each do
    @model = Region
    @game = Factory :game
    @map = Factory :map
    @region = Factory :region, :map => @map, :game => @game
    @zone = Factory :zone, :region => @region
  end

  context "as an admin" do
    context "on GET to :index with a game" do
      it_should_behave_like "GET index"

      def do_get format='html'
        get :index, :game_id => @game, :format => format
      end
    end

    it_should_behave_like "standard GET show"
    it_should_behave_like "standard PUT update"
  end

  context "as a player" do
    it "should not allow me to update regions not mine"
  end
end
