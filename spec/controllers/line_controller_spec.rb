require 'spec_helper'

describe LineController do
  before :each do
    @line = Line.all.first
    @game = Game.all.first
    @zone = Zone.all.first
  end

  context "on GET to" do
    context "for HTML" do
      context ":index with game" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:lines) }
      end

      context ":index with game and zone" do
        before do
          get :index, :game => @game, :zone => @zone
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:lines) }
      end

      context ":new" do
        before do
          get :new, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:line).with_kind_of(Line) }
      end

      context ":edit" do
        before do
          get :edit, :id => @line
        end

        it { should respond_with :success }
        it { should render_template :edit }
        it { should assign_to(:line).with(@line) }
      end

      context ":show" do
        before do
          get :show, :id => @line
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:line).with(@line) }
      end
    end

    context "for JSON" do
      context ":index with game" do
        before do
          get :index, :game => @game, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end

      context ":show" do
        before do
          get :show, :id => @line, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    before do
      #TODO line params?
      @data = {}
    end

    context "for HTML" do
      it "should create a line" do
        proc { post :create, :line => @data }.should change(Line, :count).by(1)
        should respond_with :success
        # TODO check that params are saved
      end
    end

    context "for JSON" do
      before do
        post :create, :line => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :update" do
    before do
      #TODO line params?
      @data = {}
    end
    context "for HTML" do
      before do
        put :update, :id => @line, :line => @data
      end

      it { should respond_with :success }
      it "should update the generator type" do
        # TODO check that it is updated
      end
    end

    context "for JSON" do
      before do
        put :update, :id => @line, :line => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
