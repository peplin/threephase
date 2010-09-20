require 'spec_helper'

describe RegionsController do
  before :each do
    @model = Region
    @game = Factory :game
    @map = Factory :map
    @region = Factory :region, :map => @map, :game => @game
    @zone = Factory :zone, :region => @region
  end

  context "as an admin" do
    context "on GET to" do
      context "index" do
        it_should_behave_like "GET index"

        def do_get format='html'
          get :index, :game => @game, :format => format
        end
      end

      context "show with a game" do
        it_should_behave_like "GET show"

        def do_get format='html'
          get :show, :game => @game, :id => @region, :format => format
        end
      end
    end

    # TODO POST?
    #  @data = {:map => @map, :game => @game, :user => @user,
    #      :name => "Big Town", :research_budget => 1}

    context "on PUT to :update" do
      context "with valid data" do
        before do
          @data = Factory.attributes_for :region
        end

        it_should_behave_like "successful PUT update"

        def do_put
          put :update, :id => @region, :region => @data
        end
      end

      context "with invalid data" do
        it_should_behave_like "unsuccessful PUT update"

        def do_put
          put :update, :id => @region
        end
      end
    end
  end

  context "as a player" do
    it "should not allow me to update regions not mine"
  end
end
