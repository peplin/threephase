require 'spec_helper'

describe GeneratorController do
  before :each do
    @generator = Generator.all.first
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
        it { should assign_to(:generators) }
      end

      context ":index with game and zone" do
        before do
          get :index, :game => @game, :zone => @zone
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:generators) }
      end

      context ":new with a game" do
        before do
          get :new, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:generator).with_kind_of(Generator) }
      end

      context ":new with a game and zone" do
        before do
          get :new, :game => @game, :zone => @zone
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:generator).with_kind_of(Generator) }
        it { assigns(:generator).zone.should eq(@zone) }
      end

      context ":edit" do
        before do
          get :edit, :id => @generator
        end

        it { should respond_with :success }
        it { should render_template :edit }
        it { should assign_to(:generator).with(@generator) }
      end

      context ":show" do
        before do
          get :show, :id => @generator
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:generator).with(@generator) }
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
          get :show, :id => @generator, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    before do
      #TODO generator params?
      @data = {}
    end

    context "for HTML" do
      it "should create a generator" do
        proc { post :create, :generator => @data
            }.should change(Generator, :count).by(1)
        should respond_with :success
        # TODO check that params are saved
      end
    end

    context "for JSON" do
      before do
        post :create, :generator => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :update" do
    before do
      #TODO generator params?
      @data = {}
    end
    context "for HTML" do
      before do
        put :update, :id => @generator, :generator => @data
      end

      it { should respond_with :success }
      it "should update the generator type" do
        # TODO check that it is updated
      end
    end

    context "for JSON" do
      before do
        put :update, :id => @generator, :generator => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
