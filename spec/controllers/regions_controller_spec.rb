require 'spec_helper'

describe RegionsController do
  before :each do
    @game = Game.all.first
    @region = Region.all.first
    @zone = Zone.all.first
    @map = Map.all.first
  end

  context "on GET to" do
    context "for HTML" do
      context ":index" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:regions) }
      end

      context ":show with a game" do
        before do
          get :show, :game => @game, :id => @region
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:region).with(@region) }
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
          get :show, :game => @game, :id => @region, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  # TODO POST?
  #  @data = {:map => @map, :game => @game, :user => @user,
  #      :name => "Big Town", :research_budget => 1}

  context "on PUT to :update" do
    before do
      @data = {:name => "Big Town", :research_budget => 42}
    end

    context "for HTML" do
      before do
        put :update, :id => @region, :region => @data
      end

      it { should redirect_to region_path @region }
      it "should update the region" do
        # TODO check that it is updated
      end
    end

    context "for JSON" do
      before do
        put :update, :id => @region, :region => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
