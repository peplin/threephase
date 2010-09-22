require 'spec_helper'

describe GeneratorsController do
  before :all do
    @model = Generator
  end

  before :each do
    @generator = Factory :generator
    @game = Factory :game
    @zone = Factory :zone
    @data = Factory(:generator).attributes
  end

  context "as an admin" do
    context "on GET to :index with a game" do
      it_should_behave_like "GET index"

      def do_get format='html'
        get :index, :game_id => @game, :format => format
      end
    end

    context "on GET to :new with a game" do
      it_should_behave_like "successful GET new"

      def do_get format='html'
        get :new, :game_id => @game, :format => format
      end
    end

    it_should_behave_like "standard GET edit"
    it_should_behave_like "standard GET show"

    context "on POST to :create" do
      context "with valid data" do
        it_should_behave_like "standard successful POST create"

        def redirect_path
          region_path @zone.region
        end
      end

      context "with invalid data" do
        it_should_behave_like "standard unsuccessful POST create"
      end
    end

    context "on PUT to :update" do
      context "with valid data" do
        it_should_behave_like "standard successful PUT update"

        def do_put format='html'
          put :update, :id => @generator, :generator => @data, :format => format
        end
      end

      context "with invalid data" do
        it_should_behave_like "standard unsuccessful PUT update"
      end
    end
  end

  context "as an authorized player" do
    it "should allow me to create a generator for my game"
    it "should allow me to update a my generator"
  end
  
  context "as an unauthorized player" do
    it "should not allow me to create a generator for someone else's game"
    it "should not allow me to update someone else's generator"
  end

  context "as an anonymous user" do
    it "should not allow me to create a generator"
  end
end
