require 'spec_helper'

describe ZonesController do
  before :each do
    @game = Game.all.first
    @zone = Zone.all.first
  end

  context "on GET to" do
    context "for HTML" do
      context ":index with a game" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:zones) }
      end

      context ":index with a game and region" do
        before do
          get :index, :game => @game, :region => @region
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:zones) }
      end

      context ":show" do
        before do
          get :show, :id => @zone
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:zone).with(@zone) }
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
          get :show, :id => @zone, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    before do
      @data = Factory.attributes_for :zone
    end

    context "for HTML" do
      it "should create an zone" do
        proc { post :create, :zone => @data }.should change(Zone, :count).by(1)
        should redirect_to zone_path @zone
        # TODO check that params are saved
      end
    end

    context "for JSON" do
      before do
        post :create, :zone => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
