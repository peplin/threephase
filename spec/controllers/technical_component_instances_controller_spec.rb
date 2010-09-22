require 'spec_helper'

share_examples_for "a technical component instance" do
  before :all do
    @assigns_model_name = :instance
    @pluralized_assigns_model_name = :instances
  end

  before :each do
    @game = Factory :game
    @zone = Factory :zone
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
          symbol = @instance.class.to_s.underscore.to_sym
          put :update, :id => @instance, symbol => @data, :format => format
        end
      end

      context "with invalid data" do
        it_should_behave_like "standard unsuccessful PUT update"
      end
    end
  end

  context "as an authorized player" do
    it "should allow me to create an instance for my game"
    it "should allow me to update a instance"
  end
  
  context "as an unauthorized player" do
    it "should not allow me to create an instance for someone else's game"
    it "should not allow me to update someone else's instance"
  end

  context "as an anonymous user" do
    it "should not allow me to create an instance"
  end
end

describe StorageDevicesController do
  before :all do
    @model = StorageDevice
    @instance = Factory :storage_device
  end

  it_should_behave_like "a technical component instance"
end

describe LinesController do
  before :all do
    @model = Line
    @instance = Factory :line
  end

  it_should_behave_like "a technical component instance"
end

describe GeneratorsController do
  before :all do
    @model = Generator
    @instance = Factory :generator
  end

  it_should_behave_like "a technical component instance"
end

