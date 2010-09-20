require 'spec_helper'

describe RepairsController do
  before :each do
    @game = Factory :game
    @repair = Factory :repair
    @generator = Factory :generator
  end

  context "on GET to" do
    context "for HTML" do
      context ":index with a game" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:repairs) }
      end

      context ":index with a generator" do
        before do
          get :index, :generator => @generator
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:repairs) }
      end

      context ":show" do
        before do
          get :show, :id => @repair
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:repair).with(@repair) }
      end
    end

    context "for JSON" do
      context ":index" do
        before do
          get :index, :game => @game, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end

      context ":show" do
        before do
          get :show, :id => @repair, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    before do
      @data = Factory.attributes_for :repair
    end

    context "for HTML" do
      it "should create an repair" do
        proc { post :create, :repair => @data
            }.should change(Repair, :count).by(1)
        should redirect_to generator_repair_path @generator
        # TODO check that params are saved
      end
    end

    context "for JSON" do
      before do
        post :create, :repair => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
