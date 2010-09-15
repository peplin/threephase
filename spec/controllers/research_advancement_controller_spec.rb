require 'spec_helper'

describe ResearchAdvancementController do
  before :each do
    @game = Game.all.first
    @advancement = ResearchAdvancement.all.first
  end

  context "on GET to" do
    context "for HTML" do
      context ":index" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:advancements) }
      end

      context ":show" do
        before do
          get :show, :id => @advancement
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:advancement).with(@advancement) }
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
          get :show, :id => @advancement, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    before do
      #TODO advancement params?
      @data = {}
    end

    context "for HTML" do
      it "should create an advancement" do
        proc { post :create, :advancement => @data
            }.should change(ResearchAdvancement, :count).by(1)
        should respond_with :success
        # TODO check that params are saved
      end
    end

    context "for JSON" do
      before do
        post :create, :advancement => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
